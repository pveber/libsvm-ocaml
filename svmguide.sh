#!/bin/bash

# This script downloads the Astroparticle dataset mentioned in the SVM guide
# www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf and executes the second
# command set on page 9 with the OCaml command line interface.

URL="http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary"
DATADIR="./data"

TRAINFILE=svmguide1
TESTFILE=svmguide1.t

SVM="./svm_cli.native"

if [ ! -f "$DATADIR/$TRAINFILE" ] || [ ! -f "$DATADIR/$TESTFILE" ]
then
  printf "Downloading training and testing data..."
  mkdir   -p $DATADIR &&
  wget -q -P $DATADIR "$URL/$TRAINFILE" &&
  wget -q -P $DATADIR "$URL/$TESTFILE"
  printf " finished!\n"
fi

if [ ! -f "$SVM" ]
then
  echo "$SVM not found. Type 'make' for building it."
  exit 1
fi

TRAINFILE="$DATADIR/$TRAINFILE"
TESTFILE="$DATADIR/$TESTFILE"
SCALEPARAMSFILE="$DATADIR/range1"

$SVM scale -l -1 -u 1 -s $SCALEPARAMSFILE $TRAINFILE > $TRAINFILE.scale &&
$SVM scale -r $SCALEPARAMSFILE $TESTFILE > $TESTFILE.scale &&
$SVM train $TRAINFILE.scale &&
$SVM predict $TESTFILE.scale $TRAINFILE.scale.model $TESTFILE.predict
