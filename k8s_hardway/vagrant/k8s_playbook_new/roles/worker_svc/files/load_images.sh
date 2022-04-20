#/bin/bash

export PATH=$PATH:/usr/local/bin
docker="nerdctl -n k8s.io"

if [ -z $1 ];then
  #echo -e "\033[32m no parameter!\n usage: ./$0 imagesDir
  #\033[0m"
  #exit 1
  Dir=$(pwd)
else
  Dir=$1
fi

if [ ! -z $2 ];then
  #echo -e "\033[32m no parameter!\n usage: ./$0 imagesDir
  #\033[0m"
  #exit 1
  FILES=${FILES/\/\//\/}
else
  FILES=".*[xg]z$"
fi


if [ -d $Dir ];then
  find $Dir -regex "$FILES" -type f|awk '{print $NF}'|while read line;do
      img=$line
      img=${img%%.tar*}
      img=${img#*dcs_}
      img=${img:1}
      img=${img/--/:}
      img=${img//__//}
      [[ ! $img =~ ":" ]] && img=${img/_/:}
      img=${img##*/}
      $docker images --format "{{.Repository}}:{{.Tag}}"|grep $img || {
          echo "$img ..."
          echo "$docker load -i $line"|sh
      }
  done
else
   $docker load -i $1
fi

