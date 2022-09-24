git config --global user.email "superioros123@gmail.com"
git config --global user.name "superioros-bot"
git fetch
git pull
COMMIT_MESSAGE=$(cat commit_mesg.txt)
rm tag.txt
rm commit_mesg.txt
rm release_notes.txt
rm urls.txt
git add .
git commit -m "$COMMIT_MESSAGE"
git push origin thirteen