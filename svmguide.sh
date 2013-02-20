#!/bin/bash

# This script downloads the Astroparticle dataset mentioned in the SVM guide
# www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf and executes the second
# command set on page 9 with the OCaml command line interface.

DATA_URL="http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary"
DATA_DIR="./data"
SVM_CLI="./svm_cli.native"

if [ ! -e "$DATA_DIR" ]
then
  printf "Downloading training and testing data..."
  mkdir $DATA_DIR &&
  wget -q -P $DATA_DIR $DATA_URL/svmguide1 &&
  wget -q -P $DATA_DIR $DATA_URL/svmguide1.t
  printf " finished!\n"
fi

if [ ! -f "$SVM_CLI" ]
then
  echo "$SVM_CLI not found. Type 'make' for building it."
  exit 1
fi

TRAIN_SET_FILE="$DATA_DIR/svmguide1"
TEST_SET_FILE="$DATA_DIR/svmguide1.t"
SCALE_PARAMS_FILE="$DATA_DIR/range1"

export CAML_LD_LIBRARY_PATH=$CAML_LD_LIBRARY_PATH:./_build/lib

$SVM_CLI scale -l -1 -u 1 -s $SCALE_PARAMS_FILE $TRAIN_SET_FILE > $TRAIN_SET_FILE.scale &&
$SVM_CLI scale -r $SCALE_PARAMS_FILE $TEST_SET_FILE > $TEST_SET_FILE.scale &&
$SVM_CLI train $TRAIN_SET_FILE.scale $TRAIN_SET_FILE.scale.model &&
$SVM_CLI predict $TEST_SET_FILE.scale $TRAIN_SET_FILE.scale.model $TEST_SET_FILE.predict
