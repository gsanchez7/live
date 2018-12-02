<!DOCTYPE html>
<html>
<?php include("../head/findHead.php") ?>
<body class="site">
	<?php
        if (isset($_COOKIE['auth_token'])) {
			include("../nav/dashboardNav.php");
        }

        else {
			include("../nav/nav.php");
        }
    ?>
	<main class="site-content is-centered has-text-centered">
		<div id="main-cont" class="columns">
			<?php include('findMap.php') ?>
			<?php include('form.php') ?>
		</div>
	</main>
<?php include("../footer/footer.php"); ?>
</body>
<script>
	feather.replace();
</script>
</html>