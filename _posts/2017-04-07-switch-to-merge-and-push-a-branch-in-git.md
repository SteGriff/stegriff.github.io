# Switch to, merge, and push a branch in git

To switch to a branch, use `checkout`. It's important that you *don't* use the `-b` option - this creates a new branch even if it already exists on a remote (i.e. in GitHub origin). If you're used to having different branches checked out in different folders (as an SVN user) then you can make a copy of the whole repo folder that you have previously checked out, and run this command from within the copy:

	git checkout gh-pages

Now, if you anticipate an easy merge from `master`, and you're happy for git to commit the merge for you right away, you can simply run:

	git merge master

For a paranoid merge which you're worried about, you can turn off the automatic commit and/or manually edit the commit message. After this, you will have to `git commit` as usual:

	git merge --no-commit -e master

Presuming you went for the easy route, all the changes should whizz past in the console. Now all you need to do is push `gh-pages` to origin:

	git push origin gh-pages

This takes a force of willpower if you're very used to typing `git push origin master` but you can do it! I believe in you.