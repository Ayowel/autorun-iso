#!/bin/bash

mkdir -p target
(
    filelist_path='../target/file_list'
    iso_path='../target/autorun.iso'

    cd content
    # Build file list
    find . -mindepth 1 > "$filelist_path"
    # Build ISO
    xorriso_args=(
         -uid 0 -gid 0
         -volid "AUTORUN_TEST_VOLUME"
         -preparer ''
         --gpt_disk_guid "$( printf "0%.0s" {1..32} )" 
         --set_all_file_dates set_to_mtime
         -input-charset utf8
         -path-list "$filelist_path"
    )
    SOURCE_DATE_EPOCH=0 xorrisofs "${xorriso_args[@]}" > "$iso_path"
)
