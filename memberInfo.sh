#!/bin/bash
if [ "$#" -ne 2 ]; then
  echo "usage: $0 twitterUserHandle listname"
  exit
fi
echo "cleaning up"
rm "$1"_"$2".json
echo "getting list members"
t list members --csv @"$1"/"$2" | csv2tsv | tsv2json > "$1"_"$2".json
echo "done"
