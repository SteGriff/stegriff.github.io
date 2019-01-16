# Merging across seperate repositories in SVN

We have a client who has the same product in two repositories; one repository is maintained for the main site, and the other is for developing a subset of backend features. Nevertheless, trunk changes from the site repository need to be merged across into the other. Ideally these would be set up as branch and trunk of the same repo, but sometimes Life's Like That. I'm going to refer to them as the `Main` and `Special` repositories.

## 1. Find out how far behind is `Special`

Go into the `Special` directory and open the SVN log. The revision numbers won't match those in the other repo, so look at the dates. Find the date and time that the `Main` changes were last merged in (or when the repository was created if there have been no merges). 

Now go to `Main`'s log, find the number of the *first revision that came after the date you found*, and write it down.

### Example 

So, say the `Special` was last synced on 10th December at 14:30, and in `Main`, there were two commits that day:

	2512	stephen.griffiths	10 December 2016 15:44	Master template style
	2511	stephen.griffiths	10 December 2016 09:10	Fix logger lines null check

We know that 2511 *was* included in the previous merge (because 2511 happened before 14:30) but 2512 *was not*. So we write down 2512.

## 2. Create a patch for the elapsed time period

The [`svn diff` command][diff] (which is used to create patches) isn't allowed to diff across two separate repositories. But fortunately, both `Main` and `Special` come from the same heritage, so we can use `Main` as the authoritative history.

Open an Admin Command Prompt (doesn't matter where) and run (with your repo URLs):

	svn diff http://server.mysite.co.uk:8080/svn/MainProject/trunk@2512 http://server.mysite.co.uk:8080/svn/MainProject/trunk > sync-trunk.patch
	
This will take all the changes between rev 2512 and the present day (HEAD) and put them in a new patch file, `sync-trunk.patch`.

## 3. Apply the patch in your `Special` working copy

Open the patch file using TortoiseSVN Apply Patch (or whatever you normally use to apply patches), select your `Special` trunk working copy folder, and apply the patch.

You can now review any failed hunks (hopefully few/none), and then commit the changes to the `Special` repository.

Hope it works for you :)

[diff]: http://svnbook.red-bean.com/en/1.7/svn.ref.svn.c.diff.html