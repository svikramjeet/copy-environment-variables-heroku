# The script below allows you to easily copy all Heroku ENV Vars  to local system

# Getting Started
# 1. Have Heroku CLI installed on machine
#    (https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
# 2. Run "heroku login" to login from command line
# 3. Run "heroku apps" to quickly see the names of your apps

# Instructions
# 1. Add this script file to the Desktop, "cd" into Desktop,
#    run "bash ./localtoapp.sh source-file-path target-app-name"
# 2. Enjoy new Config Vars!
# (Note: if same key exists in new Heroku project, it will be overwritten)

set -e

sourceApp="$1"
targetApp="$2"
# ignoredKeys=(IGNORE_THIS_KEY ALSO_IGNORE_THIS_KEY ADD_IGNORED_KEYS_HERE)
config=""

while read key value; do
  key=${key%%:}

  if [[ ${ignoredKeys[*]} =~ $key ]];
    then
      echo "Ignoring $key=$value"
    else
      config="$config $key=$value"
  fi
done < <(cat $filePath)

eval "heroku config:set $config --app $targetApp"
