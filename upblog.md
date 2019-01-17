# Blog Index

## Welcome!

This blog is my notebook of **solved problems, thoughts, and stuff I made**.

It runs on Jekyll, and used to be powered by [Upblog](/upblog/about-upblog), hence the name. I have an old wordpress blog at [stegriff.wordpress.com](http://stegriff.wordpress.com)

## All {{site.posts.size}} posts

<div>
{% for post in site.posts %}
<section>
	<h2>
		<a href="{{post.url}}">
			{{post.title}}
		</a>
	</h2>
	<p>
		{{post.content | strip_html | truncatewords: 50}}
	</p>
	<p class="f6 i"><time datetime="{{post.date}}">{{post.date | date_to_long_string}}</time></p>
</section>
{% endfor %}
</div>