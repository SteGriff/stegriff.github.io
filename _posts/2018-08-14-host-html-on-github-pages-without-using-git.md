# Host HTML on GitHub Pages without using git

This is a companion post for [easy and free ways to host a static website][easy]. Here's how you can use the GitHub web interface to make a new HTML website without touching git or the command line!

[easy]: ./easy-and-free-ways-to-host-a-static-website

Open GitHub in your browser, login (or make an account and login) then go to New Repository

<img class="fn" alt="Clicking on new repository" src="./posts/github-pages/newrepo.jpg">

Enter some details for the repository and click on Create - you don't need to initialise it with any files.

<img class="fn" alt="Setting up a new repository" src="./posts/github-pages/createrepo.jpg">

When it's created, you'll see the Quick Setup screen. Click on the link to create a README file, we're going to use it to make an `index.html` instead.

<img class="fn" alt="Clicking on the link to create a new README file" src="./posts/github-pages/addfile.jpg">

Now you're in a file editor. Change the filename to `index.html` and put your HTML in the file content. You can [borrow the HTML I wrote][borrow]. When you're done, scroll down and click on the 'Commit' button.

[borrow]: https://github.com/SteGriff/static-web/blob/master/index.html

<img class="fn" alt="Adding file content" src="./posts/github-pages/index.jpg">

You'll be taken back to the repository files view. Click on the repo 'Settings' cog.

<img class="fn" alt="Going to settings from the repository page" src="./posts/github-pages/gosettings.jpg">

Scroll down to GitHub Pages, open the dropdown, and choose the 'master' branch. Then click 'Save'

<img class="fn" alt="Configuring GitHub Pages to use the master branch" src="./posts/github-pages/ghpages.jpg">

When you're done, scroll back down to that section and it will now have a link to your site. For me, it's <https://stegriff.github.io/static-web/>. You can use this config section to set up custom domains to point to your site!

Here's one I made earlier:

<img class="fn" alt="The finished site in the browser" src="./posts/github-pages/finished.jpg">

This works like any HTML site, and you can add more HTML, CSS, images, and JavaScript by using the 'Create new file' or 'Upload files' buttons on the repository front page.

