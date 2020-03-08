#Userdata for onbaording softwares
mkdir HelloWorldApp
chmod 777 HelloWorldApp
cd HelloWorldApp
ls -alrt

#install java
sudo yum install java-1.8.0-openjdk

wget "URL"

java -jar -Dserver.port=8080 -Dspring.profiles.active=dev test-0.0.1-SNAPSHOT.jar $

echo "ps -u ec2-user"
