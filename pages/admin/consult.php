<?php session_start(); ?>
<?php
if(isset($_SESSION['id']) && $_SESSION['id'] == 0){
if(isset($_GET['id'])){
	$id =  htmlentities($_GET['id'],ENT_QUOTES);
}else{
	$id = 0;
}
?>
<html>
<head>
	<title>Administartion</title>
</head>
<style type="text/css">
body {
	font-family: Helvetica;
	padding: 20px;
	border-left:1px solid black;
	border-right:1px solid black;
	box-shadow: 0px 0px 10px black;
	width: 800px;
	margin: auto;
}
h1 {
	text-align: center;
}
.menu {
	text-decoration: none;
	color:#428bca;
	margin-left: 50px;
}
table{
	width: 750px;
	margin:auto;
}
thead {
	text-align: left;
}
</style>
<body>
	<h1>Panneau d'administration</h1>
		<br><br>
		<?php
		try{
			$bdd = new PDO('mysql:host=localhost;dbname=planmytrip', 'root', '', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));
			mysql_set_charset('utf8');
		}
		catch (Exception $e){
			die('Erreur : ' . $e->getMessage());
		}
		$requete = $bdd->prepare('SELECT * FROM Guide WHERE Id_Guide = ? ;');
		$requete->execute(array($id));
		?>
		<?php
			while($guide = $requete->fetch()){
					if(isset($_GET['etat'])){
						if($_GET['etat'] == 1){
							$update = $bdd->prepare('UPDATE Guide SET isValide = ? WHERE Id_Guide = ?');
							$update->execute(array(1, $guide['Id_Guide']));
						}
						if($_GET['etat'] == 0){
							$update = $bdd->prepare('UPDATE Guide SET isValide = ? WHERE Id_Guide = ?');
							$update->execute(array(0, $guide['Id_Guide']));
						}
					}
		?>
			Pays : <?php echo($guide['Pays']); ?><br>
			Ville : <?php echo($guide['Ville']); ?><br>
			Durée : <?php echo($guide['duration']); ?><br>
			Date de soumission : <?php echo ($guide['Datetime']); ?><br>
			Etat : <?php 
			if($guide['isValide'] == 1){
				echo "<img src='../img/conf.png'/>";
			}else{
				echo "<img src='../img/unconf.png'/>";
			}
			?>
			<?php echo $guide['Contenu']; ?>

			<a href="http://<?php echo $_SERVER['HTTP_HOST'] ?>/PlanMyTrip/admin/consult.php?id=<?php echo $guide['Id_Guide'] ?>&etat=1" style="text-decoration:none;color:green;">Valider</a> | 
			<a href="http://<?php echo $_SERVER['HTTP_HOST'] ?>/PlanMyTrip/admin/consult.php?id=<?php echo $guide['Id_Guide'] ?>&etat=0" style="text-decoration:none;color:red;">Refuser</a>

		<?php
			}
			$requete->closeCursor();
		?>
	<?php } ?>
</body>
</html>