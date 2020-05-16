#!/bin/bash

cd /var/lib/jenkins/jobs/dev-auto-deploy/jobs
for i in `ls ./ | tr " " "\?"`
do
   cd /var/lib/jenkins/jobs/dev-auto-deploy/jobs/
   echo "cd ${i}/builds"

   cd "${i}/builds"

   ls -l | grep  "last" | awk '{print $NF}' | grep -v "\-1" > /tmp/jenkinslog
   for file in `ls -l | grep -v legacyIds | grep -v last | awk '{print $NF}'`
   do
      if [ `grep -R $file /tmp/jenkinslog | wc -l` == "0" ];then
	      echo "rm -rf $file"
	      rm -rf $file
	  fi
   done
   rm /tmp/jenkinslog
   cd ../..

done
