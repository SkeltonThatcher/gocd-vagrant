sudo apt-get update

# install and start GoCD server and agent
# source: http://www.go.cd/documentation/user/current/installation/install/server/linux.html#debian-based-distributions-ie-ubuntu

echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > gocd.list
sudo mv gocd.list /etc/apt/sources.list.d/
wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y go-server

sudo etc/init.d/go-server start &

# agent
wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y go-agent

sudo /etc/init.d/go-agent start &

# install gauntlt
sudo apt-get install -y ruby # requires ruby
sudo apt-get install -y ruby-dev # to build gem native extensions
sudo apt-get install -y build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool # packages require to build gem native extensions

sudo gem install gauntlt

# install security tools
sudo apt-get install -y nmap # nmap
git clone https://github.com/sqlmapproject/sqlmap.git sqlmap-dev # sqlmap (recommended installation)

 
