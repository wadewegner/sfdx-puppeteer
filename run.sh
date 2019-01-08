
export FORCE_SPINNER_DELAY=
export FORCE_SHOW_SPINNER=

printf -- 'Creating a scratch org ... \n';
org="$(sfdx force:org:create -s -f config/project-scratch-def.json --json)"

printf -- 'Installing the package (this may take a couple minutes) ... \n';
sfdx force:package:install --package 04t6A000001aR9rQAE --wait 10 --noprompt

printf -- 'Setting the permission set ... \n';
permset="$(sfdx force:user:permset:assign -n GIFter)"

printf -- 'Generating the scratch org url ... \n';
url="$(sfdx force:org:open -r --json --path one/one.app#/n/GIFter | jq -r .result.url)"

printf -- 'Executing Puppeteer through run.js ... \n';
node run.js $url

printf -- '\n\033[32mComplete! \033[0m Take a look at org.png to see a picture of your org.\n';
exit 0;