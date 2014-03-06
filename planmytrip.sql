-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Jeu 06 Mars 2014 à 16:31
-- Version du serveur: 5.6.12-log
-- Version de PHP: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `planmytrip`
--
CREATE DATABASE IF NOT EXISTS `planmytrip` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `planmytrip`;

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `Id_Admin` int(11) NOT NULL,
  `Pseudo` text NOT NULL,
  `Password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `guide`
--

CREATE TABLE IF NOT EXISTS `guide` (
  `Id_Guide` int(11) NOT NULL AUTO_INCREMENT,
  `Titre` text NOT NULL,
  `Contenu` text NOT NULL,
  `Id_User` int(11) NOT NULL,
  `Pays` text NOT NULL,
  `Ville` text,
  `Datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `duration` int(1) NOT NULL,
  `Upvote` int(11) DEFAULT NULL,
  `Downvote` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Guide`),
  KEY `Id_User` (`Id_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `guide`
--

INSERT INTO `guide` (`Id_Guide`, `Titre`, `Contenu`, `Id_User`, `Pays`, `Ville`, `Datetime`, `duration`, `Upvote`, `Downvote`) VALUES
(3, 'YOLO', 'AAAyolo', 8, 'France', 'Paris', '2014-03-06 16:27:34', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `jointag`
--

CREATE TABLE IF NOT EXISTS `jointag` (
  `Id_Tag` int(11) NOT NULL,
  `Id_Guide` int(11) NOT NULL,
  KEY `Id_Tag` (`Id_Tag`,`Id_Guide`),
  KEY `Id_Guide` (`Id_Guide`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tag`
--

CREATE TABLE IF NOT EXISTS `tag` (
  `Id_Tag` int(11) NOT NULL AUTO_INCREMENT,
  `Libelle` text NOT NULL,
  PRIMARY KEY (`Id_Tag`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `tag`
--

INSERT INTO `tag` (`Id_Tag`, `Libelle`) VALUES
(1, 'metal');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `Id_User` int(11) NOT NULL AUTO_INCREMENT,
  `FullName` text NOT NULL,
  `Pseudo` text NOT NULL,
  `Mail` text NOT NULL,
  `Password` text NOT NULL,
  `ValidateKey` text NOT NULL,
  `IsValidate` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id_User`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`Id_User`, `FullName`, `Pseudo`, `Mail`, `Password`, `ValidateKey`, `IsValidate`) VALUES
(5, 'yolo', 'qsrg', 'qzgts@gesr.fr', '7768577dc159498e72a698815bd9bbfa524a16d5', 'd0c66db796a62b7d3ac06c19aa8950c6', 1),
(7, 'YOLOSWAG', 'Alex', 'alex@zob.fr', '7a480b14a6c9edbc9af65de21b98f699fc6aa63f', 'b5db3d89dd70136d98224b3b3d1780e7', 1),
(8, 'Péquin Mathieu', 'M3te0r', 'mat.pequin@gmail.com', '1045e6911dd53cb6857ad348d76626f272228664', '4136ed9f2029bf4d70bedb1178e7f899', 1);

-- --------------------------------------------------------

--
-- Structure de la table `votes`
--

CREATE TABLE IF NOT EXISTS `votes` (
  `idGuide` int(11) NOT NULL,
  `nbDown` int(11) NOT NULL,
  `nbUp` int(11) NOT NULL,
  PRIMARY KEY (`idGuide`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `votes`
--

INSERT INTO `votes` (`idGuide`, `nbDown`, `nbUp`) VALUES
(3, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `votesbyuser`
--

CREATE TABLE IF NOT EXISTS `votesbyuser` (
  `idGuide` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `hasVoted` tinyint(1) NOT NULL,
  PRIMARY KEY (`idGuide`),
  KEY `idUser` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `votesbyuser`
--

INSERT INTO `votesbyuser` (`idGuide`, `idUser`, `hasVoted`) VALUES
(3, 8, 1);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `guide`
--
ALTER TABLE `guide`
  ADD CONSTRAINT `guide_ibfk_1` FOREIGN KEY (`Id_User`) REFERENCES `user` (`Id_User`);

--
-- Contraintes pour la table `jointag`
--
ALTER TABLE `jointag`
  ADD CONSTRAINT `jointag_ibfk_2` FOREIGN KEY (`Id_Guide`) REFERENCES `guide` (`Id_Guide`),
  ADD CONSTRAINT `jointag_ibfk_1` FOREIGN KEY (`Id_Tag`) REFERENCES `tag` (`Id_Tag`);

--
-- Contraintes pour la table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`idGuide`) REFERENCES `guide` (`Id_Guide`);

--
-- Contraintes pour la table `votesbyuser`
--
ALTER TABLE `votesbyuser`
  ADD CONSTRAINT `votesbyuser_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `user` (`Id_User`),
  ADD CONSTRAINT `votesbyuser_ibfk_1` FOREIGN KEY (`idGuide`) REFERENCES `votes` (`idGuide`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
