set -x

# install and start GoCD server and agent

## sources:
## server - http://www.go.cd/documentation/user/current/installation/install/server/linux.html#debian-based-distributions-ie-ubuntu
## agent  - https://www.go.cd/documentation/user/current/installation/install/agent/linux.html#debian-based-distributions-ie-ubuntu

### server
time echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > gocd.list
time sudo mv gocd.list /etc/apt/sources.list.d/
time wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
time sudo apt-get update
time sudo apt-get install -y go-server

time sudo /etc/init.d/go-server start &

### agent
time sudo apt-get install -y go-agent

time sudo /etc/init.d/go-agent start &

# install ruby 

## libs required by Ruby
time sudo apt-get install -y gawk libsqlite3-dev sqlite3 libgdbm-dev pkg-config libffi-dev g++ gcc make libreadline6-dev libssl-dev libyaml-dev autoconf libncurses5-dev automake libtool bison 
## required by mysql ruby gem
time sudo apt-get install -y libmysqlclient-dev 

## download key and install rvm and ruby 2.2.1
time sudo su - go <<EOF
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 # public key required by rvm (which we use to install Ruby)
curl -L https://get.rvm.io | bash -s stable --autolibs=2 # gauntlt requires Ruby
source /var/go/.rvm/scripts/rvm
rvm mount -r https://rvm.io/binaries/debian/jessie_sid/x86_64/ruby-2.2.1.tar.bz2
rvm alias create default 2.2.1
rvm use 2.2.1
EOF

## libs to build gem native extensions
time sudo apt-get install -y ruby-dev 
time sudo apt-get install -y build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool

# install security tools

## gauntlt framework
time sudo su - go <<EOF
  gem install gauntlt --no-ri --no-rdoc
EOF

## nmap tool
time sudo apt-get install -y nmap # nmap

## sqlmap tool
time $(wget -q https://github.com/sqlmapproject/sqlmap/tarball/master ; tar -xf master ; mv sqlmapproject-* sqlmap)

# install dependencies required for Railsgoat (demo app) build
time sudo su - go <<EOF
  gem install bundle --no-ri --no-rdoc
EOF

# configure pipeline for Go server
# - we need to construct Go's config XML by concatenating its config after server&agent install and our pipeline configuration part
GO_SERVER_CONFIG_FILE="cruise-config.xml"

# the config file after install contains server and agent information - in between we need to include the pipeline definitions, so we split the config file in two files (server goes in cruise-config00 and agent goes in cruise-config01) 

time csplit --quiet --prefix="cruise-config" /var/lib/go-server/db/config.git/cruise-config.xml "/<agents>/" "{*}" 

time cat cruise-config00 > ${GO_SERVER_CONFIG_FILE}
time cat /vagrant/pipelines/templates/rails_build_tests_sec_deploy_pipeline.xml >> ${GO_SERVER_CONFIG_FILE} # this is our pipeline definition file
time cat cruise-config01 >> ${GO_SERVER_CONFIG_FILE} 

# now our cruise-config.xml file should have this structure:
# <server>
# <pipelines>
# <templates>
# <agents>

time sudo cp ${GO_SERVER_CONFIG_FILE} "/etc/go/${GO_SERVER_CONFIG_FILE}"

time chmod +x /vagrant/pipelines/scripts/* # make sure Go can execute the pipeline scripts

time sudo /etc/init.d/go-server start # overwriting the config file might be killing Go Server, restart here just in case

set +x