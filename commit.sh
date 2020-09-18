git add -A
git rm -r commit.sh
git rm -r config.cfg
git rm -r update.txt
read nfo
git commit -m $nfo
git push

