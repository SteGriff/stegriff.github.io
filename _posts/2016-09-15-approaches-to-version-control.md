# Approaches to Version Control

Apart from using different technologies, different people and companies take a different approach to how they employ version control. I want to talk about a couple of patterns very briefly.

## Before we begin

The SVN term "trunk" is essentially equivalent to the git term "master". In SVN, there is a distinction between Trunk and the Branches, but in git, everything's a branch and all branches are equal.

## 1. Releasable Trunk (the "GitHub flow")

"Everyone works on a branch, and the master is always deployable"

Introduced and popularised by GitHub, the [GitHub Flow][ghf1] says:

 > + Anything in the master branch is deployable
 > + To work on something new, create a descriptively named branch off of master (ie: new-oauth2-scopes)
 > + Commit to that branch locally and regularly push your work to the same named branch on the server
 > + When you need feedback or help, or you think the branch is ready for merging, open a pull request
 > + After someone else has reviewed and signed off on the feature, you can merge it into master
 > + Once it is merged and pushed to `master`, you can and should deploy immediately

This relies on the review step, because you can't push something into production if it hasn't been reviewed and unit tested. So in a contemporary version of this flow, a bot will run the unit test suite against the pull request.

I like this flow because:
 * It lends itself to automated testing and deployment
 * It encourages code review
 * It encourages frequent deployment (rapid iteration)
 * It reduces fragmentation (because there is always one and only one perfect releasable branch)
 
### How it applies to SVN

It's the same as long as you have a way of reviewing code. And since you can use SVN tools as an interface onto git, you can actually do this whole flow against a git repo and *believe* you're using SVN.

There is only one way that I have found for people to lose work in SVN, and it happens when everyone works on the trunk. Feature branches are important because it allows you to check in your work regularly and privately, without fear of messing up or being messed up by anyone. Merges are a lot easier than you think.


## 2. Production Branches

"Everyone works on the trunk, and the Live branch is always deployable"

This is another approach I regularly experience. The repository is set up with Branches for Live, Staging, etc. When somebody wants to deploy to them, they merge across trunk changes into that branch. At this point, the CI/CD server builds the branch and runs automated tests against it. When this passes, somebody can trigger a release. In my experience, there are some manual steps after triggerin the release, but it's possible to eliminate them with good enough process.

The perceived advantage of this approach is that you rarely have to merge, and everyone always has the latest version of the code. In reality, you merge every time you update, but because your trunk changes aren't checked in anywhere, you gain the neat ability of completely losing them. See my note above.

The disadvantages are:
 * Fragmentation (multiple Live branches and versions emerge to support different scenarios and emergency fixes)
 * No enforced code review
 * Discourages frequent deployment because Release becomes more of a big deal
 * Ability to lose work in SVN


## Conclusion

You can probably tell which of these I prefer. There is a wider question about how viable the GitHub flow is outside of GitHub, but there are other tools to enable that flow in other systems, and it's mostly a question of process.

 
[ghf1]: http://scottchacon.com/2011/08/31/github-flow.html