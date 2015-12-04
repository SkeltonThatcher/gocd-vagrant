sudo apt-get update

# install and start GoCD server and agent
# sources:
# server - http://www.go.cd/documentation/user/current/installation/install/server/linux.html#debian-based-distributions-ie-ubuntu
# agent  - https://www.go.cd/documentation/user/current/installation/install/agent/linux.html#debian-based-distributions-ie-ubuntu

echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > gocd.list
sudo mv gocd.list /etc/apt/sources.list.d/
wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y go-server

sudo /etc/init.d/go-server start &

# agent
wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y go-agent

sudo /etc/init.d/go-agent start &
