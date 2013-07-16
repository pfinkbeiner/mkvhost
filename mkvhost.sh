#!/bin/bash

# Might as well ask for password up-front, right?
sudo -v

HOSTS_PATH=/etc/hosts
HOST_USER=pd
vHOSTS_PATH=/etc/apache2/extra/httpd-vhosts.conf
PROJECTS_PATH=/Users/patrickfinkbeiner/development

echo "
The bash script will patch several files: 
1. /etc/hosts
2. /etc/apache/extra/httpd-vhost.conf

Also create some directories, fix permissions and finally restarts apache2.
"

echo "Please select an unique title for your new project: "
read projectName

if [ -d "$PROJECTS_PATH/$projectName" ]
	then
		echo "WARNING: Project already exist! EXIT!"
		exit
fi

#Patch hosts file
echo "
127.0.0.1 	$projectName.local
127.0.0.1 	www.$projectName.local" >> $HOSTS_PATH

#Patch virtualHosts
echo "
<VirtualHost *:80>
	ServerAdmin $HOST_USER@localhost
	DocumentRoot \"$PROJECTS_PATH/$projectName/htdocs\"
	ServerName $projectName.local
	ServerAlias www.$projectName.local
	SetEnv CONTEXT Development
	ErrorLog \"/private/var/log/apache2/$projectName-error_log\"
	CustomLog \"/private/var/log/apache2/$projectName-access_log\" common
</VirtualHost>" >> $vHOSTS_PATH


mkdir -p $PROJECTS_PATH/$projectName/htdocs

#Fix permissions
sudo chown -R _www:admin $PROJECTS_PATH/$projectName/
sudo chmod -R g+rwx $PROJECTS_PATH/$projectName/

sudo apachectl restart
echo "Finish! Project was successfully created."
