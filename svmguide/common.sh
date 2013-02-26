#!/bin/bash

DATADIR="./data"
SVMCLI="../svm_cli.native"

download ()
{
  mkdir -p $DATADIR
  for file in $*; do
    if [ ! -f "$DATADIR/$file" ]; then
      printf "Downloading file '$file'..."
      wget -q -P $DATADIR "$URL/$file"
      if [ "$?" != "0" ]; then
        printf " failed!\n"; exit 1
      else
        printf " finished!\n"
      fi
    fi
  done
}

check_svm_cli ()
{
  if [ ! -f "$SVMCLI" ]; then
    echo "$SVMCLI not found. You have to build it first."
    exit 1
  fi
}
