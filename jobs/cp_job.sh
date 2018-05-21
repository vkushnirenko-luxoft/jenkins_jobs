#!/bin/bash

#.\" Manpage for cp_job.sh
#.\" Contact vkushnirenko@luxoft.com to correct errors or typos.
#.TH man 1 "21 May 2018" "1.0" "cp_job man page"
#.SH NAME
#cp_job.sh \- create a set of NIGHTLY, PR, PUSH, ATF, ATF_Smoke jobs for new feature 
#.SH SYNOPSIS
#bash -c cp_job.sh <old_branch|app_icon_resumption> <new_branch> {create|delete}
#.SH DESCRIPTION
#cp_job is high level shell program for adding jobs to jenkins.
#.SH AUTHOR
#Vadym Kushnirenko (vkushnirenko@luxoft.com)

case "$3" in
        create)
        for i in  ATF NIGHTLY PR PUSH
            do
                    mkdir ${i}_$2
                    cp  ${i}_$1/config.xml ${i}_$2
                    find ${i}_$2 -name 'config.xml' -a -exec sed -i s/$1/$2/ {} \;
            done
        mkdir ATF_$2_Smoke
        cp ATF_$1_Smoke/config.xml ATF_$2_Smoke
        find ATF_$2_Smoke -name 'config.xml' -a -exec sed -i s/$1/$2/ {} \;
        ;;
        delete)
        for i in  ATF NIGHTLY PR PUSH
            do
                    rm -rf ${i}_$2
            done
        rm -rf ATF_$2_Smoke
        ;;
    *)
        echo $"Usage: ./$0 $1 $2 {create|delete}"
            exit 1
esac
