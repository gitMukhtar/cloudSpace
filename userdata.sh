#!/bin/bash

ds() {
  while IFS='' read -r line
    do

      if [ ! -z "$line" ] ; then
        echo "$line" | gawk ' {print strftime ("%Y-%m-%d %H:%M:%S:") , $0} ' >>/var/userdata.log

        else
          echo
        fi
      done
}
exec 1> >(ds)
exec 2>&1

java -jar -Dserver.port=8080 -Dspring.profiles.active=dev test-0.0.1-SNAPSHOT.jar $

mkdir -p /Installaers
chmod 775 /Installaers

# shellcheck disable=SC2028
echo  "\n Installing Java 1.8.0 \n"
sudo yum install java-1.8.0 -y

cd Installaers

pwd

echo "Download the HelloWorld App from repository or S3 based on your requirement"

wget https://gitMukhtar@bitbucket.org/helloWorld-App.zip

echo " Provide execute access to required jar "
chmod 775 /Installaers/helloWorld-App.zip

echo " unzip the required jar "
unzip helloWorld-App.zip

cd /Installaers/elloWorld-App/target

echo " untar the required jar "
tar -xvf test-0.0.1-SNAPSHOT.tar

echo " Navigate to the jar folder "

echo pwd

echo " Start the App "

java -jar -Dserver.port=8080 -Dspring.profiles.active=dev test-0.0.1-SNAPSHOT.jar $

WAIT=30
echo && echo -n " Waiting $WAIT seconds for service to come up"
for c in $(seq 1 "$WAIT") ; do
  echo -n "."
  sleep 1
done

PID='ps -ef | grep java | grep 'test-0.0.1-SNAPSHOT.' | awk '{ print $ 2 } ''

echo PID " The App Started "




