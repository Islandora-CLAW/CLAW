#!/bin/bash
echo "Installing Fedora."

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

if [ ! -f "$DOWNLOAD_DIR/fcrepo-$FEDORA_VERSION.war" ]; then
  echo "Downloading Fedora 4 version $FEDORA_VERSION"
  wget -q -O "$DOWNLOAD_DIR/fcrepo-$FEDORA_VERSION.war" "https://github.com/fcrepo4-exts/fcrepo-webapp-plus/releases/download/fcrepo-webapp-plus-$FEDORA_VERSION/fcrepo-webapp-plus-$FEDORA_VERSION.war"
fi

cd "$HOME_DIR"

if [ ! -d "/var/lib/tomcat7/fcrepo4-data" ]; then
  mkdir "/var/lib/tomcat7/fcrepo4-data"
fi

chown tomcat7:tomcat7 /var/lib/tomcat7/fcrepo4-data
chmod g-w /var/lib/tomcat7/fcrepo4-data

echo "CATALINA_OPTS=\"\${CATALINA_OPTS} -Dfcrepo.modeshape.configuration=classpath:/config/minimal-default/repository.json\"" >> /etc/default/tomcat7;

cp -v "$DOWNLOAD_DIR/fcrepo-$FEDORA_VERSION.war" /var/lib/tomcat7/webapps/fcrepo.war
chown tomcat7:tomcat7 /var/lib/tomcat7/webapps/fcrepo.war
sed -i 's#JAVA_OPTS="-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC"#JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms512m -Xmx1024m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=256m"#g' /etc/default/tomcat7
service tomcat7 restart

sleep 10
cp -v $HOME_DIR/islandora/install/configs/repository.json /var/lib/tomcat7/webapps/fcrepo/WEB-INF/classes/config/minimal-default/repository.json
service tomcat7 restart
