#!/usr/bin/env bash

sudo apt install openjdk-8-jre-headless -y;
sudo apt install ansible -y;

ansible-galaxy install geerlingguy.solr
ansible-playbook playbook.yml

sudo mv /var/solr/conf/schema.xml /var/solr/conf/schema.xml.backup
sudo curl -o /var/solr/conf/schema.xml https://raw.githubusercontent.com/pantheon-systems/solr-power/master/schema.xml
sudo chown solr:solr /var/solr/conf/schema.xml

# SOLR_PORT=${SOLR_PORT:-8984}

# download() {
#     echo "Downloading solr from $1..."
#     curl -s $1 | tar xz
#     echo "Downloaded"
# }

# run() {
#     echo "Starting solr on port ${SOLR_PORT}..."

#     cd /opt/solr/example
#     # java -Djetty.port=$SOLR_PORT -jar start.jar &
#     java -Djetty.port=$SOLR_PORT -jar start.jar > /dev/null 2>&1 &
#     echo "Started"
# }


# download_and_run() {
#     url="http://archive.apache.org/dist/lucene/solr/3.6.2/apache-solr-3.6.2.tgz"
#     dir_name="apache-solr-3.6.2"
#     dir_conf="conf/"

#     download $url

#     # copy schema.xml
#     rm $dir_name/example/solr/$dir_conf/schema.xml
#     curl -o $dir_name/example/solr/$dir_conf/schema.xml https://github.com/pantheon-systems/solr-power/blob/master/schema.xml
#     sudo mkdir -p /opt/solr/
#     sudo mv $dir_name/* /opt/solr/
#     # Run solr
#     run $SOLR_PORT


# }

# download_and_run $SOLR_VERSION

