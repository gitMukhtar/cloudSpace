#! /bin/bash

pwd

sudo mkdir -p Installers
sudo chmod 775 Installers

echo  " Installing Java 1.8.0 "

sudo yum install java-1.8.0 -y

sudo wget https://helloworldapp.s3.ap-south-1.amazonaws.com/myjar.zip

sudo chmod 775 myjar.zip


sudo unzip myjar.zip

echo pwd

sudo chmod 775 myjar

cd myjar

echo pwd


java -jar -Dserver.port=8080 -Dspring.profiles.active=dev test-0.0.1-SNAPSHOT.jar $

WAIT=30
echo && echo -n " Waiting $WAIT seconds for service to come up"
for c in $(seq 1 "$WAIT") ; do
  echo -n "."
  sleep 1
done

PID='ps -ef | grep java | grep 'test-0.0.1-SNAPSHOT.' | awk '{ print $ 2 } ''

echo PID " The App Started "