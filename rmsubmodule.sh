git submodule deinit -f $1
rm -rf .git/modules/$1
git rm -f $1
git commit -m "Removed $1"

