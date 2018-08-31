# The script below allows you to easily copy all Heroku ENV Vars  to local system

# Instructions
# 1. Have Heroku CLI installed on machine
#    (https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
# 2. Run "heroku login" to login from command line
# 3. Run "heroku apps" to quickly see the names of your apps
# 4. Add this script file to the Desktop, "cd" into Desktop,
#    run "bash ./copytolocal.sh source-app-name file-name-to-create"
#    eg bash ./copytolocal.sh uat .env
# 5. Enjoy new Config Vars!

set -e

sourceApp="$1"
fileName="$2"

touch $fileName
FILE=$fileName

echo "#start" >> $fileName

while read key value; do
   echo "$key='$value'" >> $FILE
done < <(heroku config --app "$sourceApp" | sed "s/://")
echo "#end" >> $fileName
