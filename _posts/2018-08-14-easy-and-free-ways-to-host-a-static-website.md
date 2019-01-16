# Easy and free ways to host a static website

I like to tell people to [keep a technical blog][katb] because it's good for your skills, your employer, your employability, the tech sector, and the economy at large. So today I want to share ways of starting a blog that range from extremely easy to quite easy and from free to extremely cheap.

Before we dive in, a quick note on dynamic vs static sites: 

 * A **dynamic** site can generate new views of its information based on what users do to it, usually by having a database and some program code which gets executed when a user visits. Examples are Wordpress, Wikipedia, or something like my [Paprika][pap] language generator tool.
 * A **static** site is written or generated and the hosted content (HTML, CSS, JS) does not change in response to users. You can still have interactivity using JavaScript that talks to remote services, but the website content cannot mutate.

A static site is all you need if you want to write and publish content. The main reason for dynamicity is wanting to host user-contributed content.

[katb]: ./keep-a-technical-blog
[pap]: https://paprika.me.uk

## 1. GitHub Pages

The stalwart. The standard. GitHub Pages is **the** way of hosting a static site for free.

 - **Price**: Free  
 - **Custom domains**: Yes  
 - **Integrations**: Good  
 - **Ease of setup**: Great  
 
You **do not need to know git** to host a website on GitHub pages.
 
I am going to describe two git-free ways of making a static site on GitHub pages. The first is writing your own HTML, the second is cloning a ready-made Jekyll website.

### Host HTML on GitHub Pages without using git

I have written a companion post showing how to [host HTML on GitHub Pages without using git][gitweb]; you do it all through GitHub's website. Please follow that guide if you're interested.

[gitweb]: ./host-html-on-github-pages-without-using-git


### Host a Jekyll site on GitHub pages without installing any software (including git)

The second way of making a site uses a ready-to-go setup of the Jekyll static site generator. In Jekyll, you can write Markdown files for your posts (instead of HTML) but still customise how your site looks using HTML, CSS, etc. if you want to.

All you have to do is go to <https://github.com/barryclark/jekyll-now>, scroll down until you see the 'Quick Start' instructions, and follow them. This essentially means forking the repository onto your account. That's it. Then you can edit your content through GitHub's web interface to craft your posts.


## 2. Netlify

Netlify is a more technical option than GH pages, requiring you to use actual development tools (more than just the browser) but adds value through better domain and https management.

 - **Price**: Free  
 - **Custom domains**: Yes  
 - **Integrations**: Great  
 - **Ease of setup**: Medium  
 
I have never actually used it, but some of my colleagues have, and you can get started at <https://www.netlify.com/>


## 3. Glitch

Glitch is, in my own words, the future of excruciatingly cool people doing collaborative coding. It is a place to make, remix, and have big fun. Under the fuzzy friendly hood, Glitch is also a fantasically sophisticated private container host (which means you can make and host dynamic apps) with a cutting-edge frontend onto version control and collaboration features.

 - **Price**: Free  
 - **Custom domains**: **No** (not yet)  
 - **Integrations**: Not so much  
 - **Ease of setup**: Perfect  
 - **Bonus features**: Dynamic sites  

On Glitch, you can start a new project using one of the templates on the 'New project' button (like 'hello-webpage') or you can remix (fork) any other project on there, like [Empty Welcome](https://glitch.com/~empty-welcome) or the [Nasa logo generator](https://glitch.com/~nasa). Scroll down to the 'Remix your own' button to get started.


## 4. Azure Storage Static Site

The Microsoft Azure team recently added a feature to Blob Storage that lets you put static sites in there. This costs a tiny amount of money, but you might want to use it if you have gigabytes of files to store (the free hosts are not very happy to store huge amounts of data)

 - **Price**: Under 4p per GB per month  
 - **Custom domains**: Yes  
 - **Integrations**: Great  
 - **Ease of setup**: Medium  

For example, hosting 10 GBs of data costs between £0.16 and £0.32 per month depending on the speed and resilience options you choose. This is a lot cheaper than any shared site hosting on the market, and you get all of the advantages of being on Azure.

This is for the slightly more technical people, and you will also need to enter credit/debit card information.

The best way to get started is by reading the news announcement, [Static website hosting for Azure Storage now in public preview][az] which has a few tips on using the Azure web portal to set up a site.

[az]: https://azure.microsoft.com/en-us/blog/azure-storage-static-web-hosting-public-preview/


## Conclusion

I've offered these options so that there is something for everybody! Whether you are going small and casual all the way up to giant and highly integrated, there is a free/cheap web hosting option for you.

If you make a website using these tips, please be free to let me know using email (ste at this domain) or tweet [@SteGriff](https://twitter.com/stegriff)!

Build Cool Stuff!