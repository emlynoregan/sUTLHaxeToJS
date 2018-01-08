echo Pushing latest build

cd "./sUTLHaxeJS" || { echo '060' ; exit 1; }
git add . || { echo '070' ; exit 1; }
if git commit -a -m "auto"
then git push origin master || { echo '090' ; exit 1; }
else echo skip push JS
fi
