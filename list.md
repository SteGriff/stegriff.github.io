Hello world

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