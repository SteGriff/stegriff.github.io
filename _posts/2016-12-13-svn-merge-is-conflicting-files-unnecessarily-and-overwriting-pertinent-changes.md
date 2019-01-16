# SVN merge is conflicting files unnecessarily and overwriting pertinent changes

## The problem

I was merging trunk changes into a branch and it was overwriting my actual work. This is unusual and not how SVN is supposed to work. Online sources asked whether I had accidentally selected "reintegrate" but I hadn't.

Eventually I figured out that there was an actual commit which explicitly reverted the changes I was trying to keep. Why?

## How I got into this pickle

We started the work for this feature on the trunk, because it was small enough and that was our habit at the time. But we were asked to move it to a branch. I used 'Copy To' in Tortoise SVN to take the current state of the trunk at that time and move it to a branch. Then I reverted the feature changes in the trunk (creating a commit, say, 2505) so that the trunk could be iterated and deployed independently.

When it came time to sync trunk changes into the branch, it also merged revision 2505, which explicitly reverts the feature changes.

## Solution

I used the merge dialogue as usual but instead of leaving the range blank, I specified a range starting *after* 2505 and up to the current commit. This merged in all the pertinent work without deleting itself. All I had to do was to exclude the single commit which was responsible for reverting the feature work.