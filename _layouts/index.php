<?php
require_once 'bits/boilerplate.php';
?>
</head>
<body>

	<?php
	require_once 'bits/header.php';
	?>
	
	<article>
		<?=$UPBLOG?>
	</article>
	
	<article class="summaries">
		<p>Loading posts, just a moment...</p>
	</article>
	
	<footer>
		<p><time class="year">2014</time> SteGriff - Stephen Griffiths</p>
	</footer>
	
	<script src="http://code.jquery.com/jquery-2.2.0.min.js"></script>
	<script>
		$(function(){
			$(".year").text(new Date().getFullYear());
			$(".summaries").load("summaries.php");
		});
	</script>
</body>
</html>