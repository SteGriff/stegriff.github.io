# The rough guide to an easy SVN merge

SVN merges can be tricky. We use TortoiseSVN here at work, as do many other .Net development places, so that will be the tool of choice for this guide. This tutorial assumes the merge of a branch into the trunk. You should have both of these checked out on your machine already.

## 1. Update

This is a dead simple sanity measure. Check you've run `SVN Update` in both the trunk and the branch.

## 2. Check for uncommitted stuff

Go to `SVN Commit` in both the branch and the trunk, and make sure that you've committed everything you want to keep. In a moment, we're going to revert all unversioned changes.

## 3. Clean up

In both branch and trunk, go to `TortoiseSVN/Clean up...` Tick:
 
 * Delete unversioned files and folders
 * Revert all changes recursively
 
This is why we made sure we committed anything earlier; we're about to clean the working copy so that it is exactly the same as the server copy, losing any changes. If the revert fails for some reason, go to `TortoiseSVN/Revert`, tick all files, and let it run. Then repeat the `Clean up`.

## 4. Sync the trunk changes into the branch

This is the major step to save us from conflicts: the branch needs to track any changes in the trunk.

In the branch folder on your PC, go to `TortoiseSVN/Merge...`:

 * Select `Merge a range of revisions`, click Next
 * Select the trunk URL at the top. Leave all other settings as they are (specific range, box is blank, Reverse merge is false), click Next
 * Click Merge
 
Now a lot of people will do a test merge, but I've found it a bit useless. It imagines conflicts which won't really happen in the real thing, and also doesn't let you do anything about them. Since you have a guarantee that all of your work is safe in either the trunk or the branch (and we can easily revert), just hit Merge.

## 5. Build and commit the branch

Check your branch still builds.

Now go to SVN Commit. You can use a message from Recent Messages in Tortoise, which will hopefully describe the changes which were rolled into your merge (although sometimes it doesn't work). I like to leave a simple note that says "Sync trunk changes".

## 6. Merge the branch into the trunk

In the trunk folder on your PC, go to `TortoiseSVN/Merge...`:

 * Select `Merge a range of revisions`, click Next
 * Select the branch URL. Leave all other settings as they are, click Next
 * Click Merge
 
## 7. Commit the trunk

Go to SVN Commit and either use an auto generated message or something like "Merge <such-and-such-a-feature> branch into trunk"

## You're done

Key principles:

 * Always have a record in the SVN server repository of all the changes you care about. As long as they're on the server, they can be retrieved.
 * Revert and clean up before interacting with other branches. Make your working copy identical to the server repository to avoid grief.
 * Always synchronise trunk changes into the branch before you merge the branch into the trunk.
 
Hope this helps!
