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
# (Note: if same key exists in new Heroku project, it will be overwritten. To avoid this give env variable keys comma separated in ignoredKeys)

set -e

filePath="$1"
targetApp="$2"
#ignoredKeys=(DATABASE_URL, APP_ENV)
config=""

while read key_value; do
  if [[ ${ignoredKeys[*]} =~ ${key_value%%=*} ]];
    then
      echo "Ignoring ${key_value%%=*}"
    else
      config="$config $key_value"
  fi
done < <(cat $filePath)
eval "heroku config:set $config --app $targetApp"
