# How I write a blog post

![Start writing](./posts/how-i-write-a-blog-post/start-writing-small.png)

Uhhhhh, this post is a bit meta in a silly way that I might regret but it looks like I'm going to [Do it Anyway][do-it]. Since last post was the [100th post on this site][post-100] (which means I post here on average every week and a half) I feel like I've acheived my personal goal to [making blogging easier][make-easier]. So here's a quick thing about how I do it...

## 1. Start writing in Notepad++

Most posts on here are about a technical problem, so I probably just paste it into Npp and then start writing around it. I love Markdown and it makes it easy to write a structured document quickly.

I save this in my local folder copy of my website file structure. To make the file name - and this bit is trickier than it should be - I copy the title from the top line, open a new Notepad++ tab (Ctrl+N), select everything (Ctrl+A), lowercase everything (Ctrl+U), open find and replace (Ctrl+H), and replace all spaces with '-'. Sometimes there are other special characters like apostrophes so I just do the same for them, and then if necessary, replace '--' with '-'. But that's a big paragraph for a process which realistically takes five seconds and which I should just turn into a macro!

## 2. Upload it

When the post is ready, I open FileZilla and connect to my website. I browse to the `/upblog/posts` dir on the server and upload the file from my local folder.

## 3. Reload the blog

There's a special URL built into Upblog which re-parses all the blog files and metadata files, creating new metadata where there is none. This essentially publishes any unpublished posts. So I just go to this URL in a new browser tab.

Fun fact: Upblog used to do this process on every guest visit, which stopped being performant after about 10 posts. So I refactored it to be a periodic bulk job.

## 4. Test it

I now go to the upblog main page and check that the post shows up in the list of recent posts. Then I proofread it one more time and test all the links.

## 5. Iterate

If it needs a fix, I just repeat step 2. None of the other steps are necessary because the metadata has already been generated (that is, once a post is published, it stays published)

[do-it]: https://www.youtube.com/watch?v=mEyrfFwf3rI
[post-100]: ./buildshadowtask-task-failed-unexpectedly-after-merging-test-projects
[make-easier]: http://stegriff.co.uk/upblog/make-blogging-easier