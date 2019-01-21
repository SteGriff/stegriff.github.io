<?php
require_once 'bits/boilerplate.php';
?>
<link rel="stylesheet" href="/keen.css">
<style type="text/css">
	#metrics
	{
		height: 150px;
		border: 1px solid transparent;
	}
	
	#TotalActivations
	{
		background: #49c5b1;
	}
	
	#UniqueActivators
	{
		background: #F84346;
	}
	
	#UniqueExporters
	{
		background: #CE61CF;
	}
	
	#TotalExports
	{
		background: #49c5b1;
	}
</style>
</head>
<body>

	<?php
	require_once 'bits/header.php';
	?>
		
	<?php
	require_once 'bits/pager.php';
	?>
	
	<article>
		<?=$UPBLOG?>
	</article>
	
	<?php
	require_once 'bits/footer.php';
	?>
	<script src="/svc/keen/emoji-keen.js"></script>

</body>
</html>