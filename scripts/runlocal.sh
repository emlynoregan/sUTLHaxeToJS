echo Start generating JS

#1: Update source
cd "$1/sUTLHaxe" || { echo '000' ; exit 1; }
git checkout master
git pull origin master  || { echo '010' ; exit 1; }

#2: Run generate and run tests
cd "$1" || { echo '020' ; exit 1; }
/usr/bin/haxe buildtests.hxml || { echo '030' ; exit 1; }
node "$1/sUTLHaxeJS/sUTLTests.js" || { echo '040' ; exit 1; }

#3: Generate the js interpreter
/usr/bin/haxe build.hxml || { echo '050' ; exit 1; }

#4: Push the new interpreter to the repo
cd "$1/sUTLHaxeJS" || { echo '060' ; exit 1; }
git checkout master
git add . || { echo '070' ; exit 1; }
if ! git commit -a -m "auto"
then git push origin master || { echo '090' ; exit 1; }
fi

#5: commit changes to self
cd "$1" || { echo '100' ; exit 1; }
git add . || { echo '110' ; exit 1; }
if ! git commit -a -m "auto"
then git push origin master || { echo '130' ; exit 1; }
fi

echo Finished generating JS