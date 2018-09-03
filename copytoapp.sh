# The script below allows you to easily copy all Heroku ENV Vars  to local system

# Getting Started
# 1. Have Heroku CLI installed on machine
#    (https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
# 2. Run "heroku login" to login from command line
# 3. Run "heroku apps" to quickly see the names of your apps

# Instructions
# 1. Add this script file to the Desktop, "cd" into Desktop,
#    run "bash ./copytoapp.sh source-app-name target-app-name"
# 2. Enjoy new Config Vars!
# (Note: if same key exists in new Heroku project, it will be overwritten)
# (if there is space between value eg NAME=DAVE SMITH, script will throw format error)

set -e

sourceApp="$1"
targetApp="$2"
# ignoredKeys=(DATABASE_URL)
config=""

while read key value; do
  key=${key%%:}

  if [[ ${ignoredKeys[*]} =~ $key ]];
    then
      echo "Ignoring $key=$value"
    else
      config="$config $key=$value"
  fi
done < <(heroku config --app "$sourceApp" | sed -e '1d')

eval "heroku config:set $config --app $targetApp"
