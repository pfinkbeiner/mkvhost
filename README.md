# MkVhost – litte bash script for fast & easy creating vhosts on your Mac.

### Problem to solve

Tired of creating vhosts over and over again? Yep, me too!
___

### Usage
* Get the latest version.
* Adjust variables for your own development enviroment.
* Save time…

This script contains seven variables you can change. You may dont want to change the last three of them.

* `USER` – Usually your local user.
* `VHOSTS_PATH` – Depends on which apache version do you use. In my case i use the pre-installed apache2 from OSX Mountain Lion. If you use the same, you don't have to change anything.
* `CONTEXT` – Maybe you also change settings depending on your enrivoment context. Default is »Development«
* `DOCUMENT_ROOT` - Where are all of your projects located? 
* `HOSTS_PATH` - Usually located always in /etc/hosts
* `ERROR_LOG_PATH` - Each project will have its own error logs.
* `ACCESS_LOG_PATH` - Each project will have its own access logs.


### Hint

Locate the script wherever you want. In my case its located in `~/.bin/mkvhost/mkvhost.sh`. For easy access i created an alias in my .bashrc like `alias mkvhost="sudo ~/.bin/mkvhost/mkvhost.sh"`. You see i added a sudo inside the alias. _You'll need sudo privileges to run the script._
