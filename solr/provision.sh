#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

apt_package_install_list=(
  openjdk-8-jre-headless
  ansible
)

echo " * Installing apt-get packages..."
if ! apt-get -y --allow-downgrades --allow-remove-essential --allow-change-held-packages -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew install --fix-missing --fix-broken ${apt_package_install_list[@]}; then
  echo " * Installing apt-get packages returned a failure code, cleaning up apt caches then exiting"
  apt-get clean
  return 1
fi

ansible-galaxy install geerlingguy.solr
ansible-playbook "${DIR}/playbook.yml"

mv /var/solr/conf/schema.xml /var/solr/conf/schema.xml.backup
curl -o /var/solr/conf/schema.xml https://raw.githubusercontent.com/pantheon-systems/solr-power/master/schema.xml
chown solr:solr /var/solr/conf/schema.xml

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

