#!/bin/bash

# Little helper script for fast vhost creation.
# Written for own development enviroment. Based on OSX Mountain Lion
# standard apache installation. No guarantee that it also fits your needs. 

# Should be executed with sudo privileges.

USER=patrickfinkbeiner
HOSTS_PATH=/etc/hosts
VHOSTS_PATH=/etc/apache2/extra/httpd-vhosts.conf
DOCUMENT_ROOT=/Users/$USER/development

# Variables you might wont change.
ERROR_LOG_PATH=/private/var/log/apache2
ACCESS_LOG_PATH=/private/var/log/apache2

# Check if given project name is already in use.
doesProjectAlreadyExist() {
	if [ -d "$DOCUMENT_ROOT/$projectName" ]
	then
		echo "WARNING: Project already exist! At least its directory."
		chooseTitle
		exit
	else
		echo "Okay, project » $projectName « will be created…"
		patchHosts
	fi
}

# Choose a title for your new project.
chooseTitle() {
	echo "Please select an unique title for your new project: "
	read projectName
	doesProjectAlreadyExist
}

##Patch hosts file
patchHosts() {
echo "
127.0.0.1 	$projectName.local
127.0.0.1 	www.$projectName.local" >> $HOSTS_PATH
createVhost
}

# Actually add new VirtualHost.
createVhost() {
echo "
<VirtualHost *:80>
	ServerAdmin $USER@$(hostname)
	DocumentRoot \"$DOCUMENT_ROOT/$projectName/htdocs\"
	ServerName $projectName.local
	ServerAlias www.$projectName.local
	SetEnv CONTEXT Development
	ErrorLog \"$ERROR_LOG_PATH/$projectName-error_log\"
	CustomLog \"$ACCESS_LOG_PATH/$projectName-access_log\" common
</VirtualHost>" >> $VHOSTS_PATH
createDir
}

# Create directory. Add additional folder names if needed.
createDir() {
	mkdir -p $DOCUMENT_ROOT/$projectName/htdocs
	fixPermissions
}

##Fix permissions
fixPermissions() {
	sudo chown -R _www:admin $DOCUMENT_ROOT/$projectName
	sudo chmod -R g+rwx $DOCUMENT_ROOT/$projectName
	restartApache
}

restartApache() {
	sudo apachectl restart
	echo "Ready! Project was successfully created and your ready to go!"
}

initialize() {
	sudo -v
	echo "
	The bash script will patch several files: 
	1. $HOSTS_PATH
	2. $VHOSTS_PATH

	Also create some directories, fix permissions and finally restarts apache2.
	"
	chooseTitle
}
initialize
