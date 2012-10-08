#!/bin/sh

real_file_name=$@
file_name=`basename "$real_file_name"`
tmp_file=`mktemp`
tmp_dir=`mktemp -d`
fake_name="$tmp_dir/$file_name"

# assumed that the source code has EUC-JP encoding                                                                                             
nkf --ic=UTF-8 --oc=EUC-JP  "$real_file_name" | kakasi -ieuc -Ha -Ka -Ja -Ea -ka -s > "$tmp_file"

mkdir -p $tmp_dir
cp $tmp_file $fake_name
chktex -g0 -r -l ~/.chktexrc -I -q -v0 $fake_name

# clean up                                                                                                                                     
rm -fr "$tmp_file"
rm -fr "$tmp_dir"
