#!/bin/bash

IP=`curl -s 'https://api.ipify.org' | uniq`
IPLOGFILE="$HOME/.ip-updater.log"

APPNAME="serveron"  # Your Heroku App Name
PORT="3000" # Port Number

function updateIP() {
  echo "$IP $(date)" >> $IPLOGFILE;
  eval "/snap/bin/heroku config:set LOCAL_SERVER=http://$IP:$PORT --app $APPNAME > /dev/null 2>&1";
}

if [ ! -f "$IPLOGFILE" ]; then
  updateIP;
else
  if [ $IP != "$(tail -n1 $IPLOGFILE | cut -d' ' -f1)" ]; then
    updateIP;
  fi
fi

