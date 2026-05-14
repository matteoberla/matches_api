-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Creato il: Mag 21, 2024 alle 16:38
-- Versione del server: 10.6.17-MariaDB-cll-lve-log
-- Versione PHP: 8.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fwowtqpu_matches_db`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `capo_azz_bet`
--

CREATE TABLE `capo_azz_bet` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bet_num` int(11) NOT NULL,
  `value` text NOT NULL,
  `is_valid` tinyint(1) NOT NULL DEFAULT 0,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `capo_azz_bet`
--

INSERT INTO `capo_azz_bet` (`id`, `user_id`, `bet_num`, `value`, `is_valid`, `points`) VALUES
(9, 32, 1, 'scamacca', 0, NULL),
(10, 32, 2, 'retegui', 0, NULL),
(11, 16, 1, 'Scamacca', 0, NULL),
(12, 16, 2, 'Chiesa', 0, NULL),
(13, 47, 1, 'scamacca', 0, NULL),
(14, 47, 2, 'pellegrini', 0, NULL),
(15, 29, 1, 'Scamacca', 0, 0),
(16, 29, 2, 'Chiesa', 0, 0),
(17, 49, 1, 'Scamacca', 0, NULL),
(18, 49, 2, 'Chiesa', 0, NULL),
(19, 54, 1, 'Retegui', 0, NULL),
(20, 54, 2, 'Scamacca', 0, NULL),
(21, 25, 1, 'Scamacca', 0, NULL),
(22, 25, 2, 'Chiesa', 0, NULL),
(23, 51, 1, 'SCAMACCA', 0, NULL),
(24, 51, 2, 'FRATTESI', 0, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `capo_euro_bet`
--

CREATE TABLE `capo_euro_bet` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bet_num` int(11) NOT NULL,
  `value` text NOT NULL,
  `is_valid` tinyint(1) NOT NULL DEFAULT 0,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `capo_euro_bet`
--

INSERT INTO `capo_euro_bet` (`id`, `user_id`, `bet_num`, `value`, `is_valid`, `points`) VALUES
(11, 32, 1, 'MbappÃ©', 0, NULL),
(12, 32, 2, 'Wirtz', 0, NULL),
(13, 16, 1, 'Kane', 0, NULL),
(14, 16, 2, 'MbappÃ¨', 0, NULL),
(15, 47, 1, 'mbappÃ¨', 0, NULL),
(16, 47, 2, 'kane', 0, NULL),
(17, 29, 1, 'Mbappe', 0, NULL),
(18, 29, 2, 'Morata', 0, NULL),
(19, 49, 1, 'Mbappe', 0, NULL),
(20, 49, 2, 'Kane', 0, NULL),
(21, 54, 1, 'MbappÃ©', 0, NULL),
(22, 54, 2, 'Fullkrug', 0, NULL),
(23, 25, 1, 'Kane', 0, NULL),
(24, 25, 2, 'Mbappe', 0, NULL),
(25, 51, 1, 'FULLKRUG', 0, NULL),
(26, 51, 2, 'MBAPPE', 0, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `conf`
--

CREATE TABLE `conf` (
  `id` int(11) NOT NULL,
  `des` text NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `value_int` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `conf`
--

INSERT INTO `conf` (`id`, `des`, `datetime`, `value_int`) VALUES
(1, 'data scadenza compilazione', '2024-06-08 20:00:00', NULL),
(2, 'versione app', NULL, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `fasi`
--

CREATE TABLE `fasi` (
  `id` int(11) NOT NULL,
  `fase` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `fasi`
--

INSERT INTO `fasi` (`id`, `fase`) VALUES
(1, 'Gironi'),
(2, 'Ottavi'),
(3, 'Quarti'),
(4, 'Semifinali'),
(5, 'Finale');

-- --------------------------------------------------------

--
-- Struttura della tabella `gironi`
--

CREATE TABLE `gironi` (
  `id` int(11) NOT NULL,
  `girone` text NOT NULL,
  `id_team_1` int(11) NOT NULL,
  `id_team_2` int(11) NOT NULL,
  `id_team_3` int(11) NOT NULL,
  `id_team_4` int(11) NOT NULL,
  `pos_1` int(11) DEFAULT NULL,
  `pos_2` int(11) DEFAULT NULL,
  `pos_3` int(11) DEFAULT NULL,
  `pos_4` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `gironi`
--

INSERT INTO `gironi` (`id`, `girone`, `id_team_1`, `id_team_2`, `id_team_3`, `id_team_4`, `pos_1`, `pos_2`, `pos_3`, `pos_4`) VALUES
(7, 'Girone A', 2, 7, 8, 6, NULL, NULL, NULL, NULL),
(8, 'Girone B', 5, 3, 1, 9, NULL, NULL, NULL, NULL),
(9, 'Girone C', 10, 11, 12, 13, NULL, NULL, NULL, NULL),
(10, 'Girone D', 14, 4, 15, 16, NULL, NULL, NULL, NULL),
(11, 'Girone E', 17, 18, 19, 20, NULL, NULL, NULL, NULL),
(12, 'Girone F', 21, 22, 23, 24, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `gironi_bet`
--

CREATE TABLE `gironi_bet` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `girone` text NOT NULL,
  `pos_1` int(11) NOT NULL,
  `pos_2` int(11) NOT NULL,
  `pos_3` int(11) NOT NULL,
  `pos_4` int(11) NOT NULL,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `gironi_bet`
--

INSERT INTO `gironi_bet` (`id`, `user_id`, `girone`, `pos_1`, `pos_2`, `pos_3`, `pos_4`, `points`) VALUES
(14, 21, 'Girone A', 1, 2, 4, 3, NULL),
(15, 21, 'Girone B', 1, 3, 2, 4, NULL),
(16, 21, 'Girone C', 4, 2, 3, 1, NULL),
(17, 21, 'Girone D', 2, 1, 3, 4, NULL),
(18, 32, 'Girone A', 1, 4, 3, 2, NULL),
(19, 32, 'Girone B', 1, 3, 2, 4, NULL),
(20, 32, 'Girone C', 4, 3, 2, 1, NULL),
(21, 32, 'Girone D', 2, 1, 3, 4, NULL),
(22, 32, 'Girone E', 2, 3, 1, 4, NULL),
(23, 32, 'Girone F', 1, 3, 4, 2, NULL),
(24, 25, 'Girone B', 1, 3, 2, 4, NULL),
(25, 16, 'Girone A', 1, 3, 4, 2, NULL),
(26, 16, 'Girone B', 1, 3, 2, 4, NULL),
(27, 16, 'Girone C', 4, 2, 3, 1, NULL),
(28, 16, 'Girone D', 2, 1, 3, 4, NULL),
(29, 16, 'Girone E', 2, 3, 1, 4, NULL),
(30, 16, 'Girone F', 1, 3, 4, 2, NULL),
(31, 25, 'Girone D', 2, 1, 3, 4, NULL),
(32, 25, 'Girone C', 4, 3, 2, 1, NULL),
(33, 25, 'Girone F', 1, 3, 4, 2, NULL),
(34, 47, 'Girone A', 1, 3, 4, 2, NULL),
(35, 47, 'Girone B', 1, 3, 2, 4, NULL),
(36, 47, 'Girone C', 4, 2, 3, 1, NULL),
(37, 47, 'Girone D', 2, 1, 4, 3, NULL),
(38, 47, 'Girone E', 2, 4, 1, 3, NULL),
(39, 47, 'Girone F', 2, 3, 4, 1, NULL),
(40, 49, 'Girone A', 1, 4, 3, 2, NULL),
(41, 49, 'Girone B', 1, 3, 2, 4, NULL),
(42, 50, 'Girone A', 1, 4, 2, 3, NULL),
(43, 50, 'Girone B', 1, 3, 2, 4, NULL),
(44, 50, 'Girone C', 4, 2, 3, 1, NULL),
(45, 50, 'Girone D', 3, 1, 4, 2, NULL),
(46, 50, 'Girone E', 2, 3, 1, 4, NULL),
(47, 50, 'Girone F', 1, 3, 4, 2, NULL),
(48, 25, 'Girone A', 1, 4, 3, 2, NULL),
(49, 25, 'Girone E', 2, 4, 1, 3, NULL),
(50, 29, 'Girone A', 1, 4, 3, 2, NULL),
(51, 29, 'Girone B', 1, 3, 2, 4, NULL),
(52, 26, 'Girone A', 1, 3, 4, 2, NULL),
(53, 26, 'Girone B', 1, 3, 2, 4, NULL),
(54, 29, 'Girone C', 4, 2, 3, 1, NULL),
(55, 26, 'Girone C', 4, 2, 3, 1, NULL),
(56, 26, 'Girone D', 2, 1, 4, 3, NULL),
(57, 26, 'Girone E', 2, 3, 1, 4, NULL),
(58, 26, 'Girone F', 1, 3, 4, 2, NULL),
(59, 29, 'Girone D', 2, 1, 4, 3, NULL),
(60, 29, 'Girone E', 2, 4, 1, 3, NULL),
(61, 29, 'Girone F', 1, 3, 4, 2, NULL),
(62, 49, 'Girone C', 4, 3, 2, 1, NULL),
(63, 49, 'Girone D', 2, 1, 4, 3, NULL),
(64, 49, 'Girone E', 2, 3, 1, 4, NULL),
(65, 49, 'Girone F', 1, 4, 3, 2, NULL),
(66, 54, 'Girone B', 1, 3, 2, 4, NULL),
(67, 54, 'Girone C', 4, 2, 3, 1, NULL),
(68, 54, 'Girone D', 2, 1, 4, 3, NULL),
(69, 54, 'Girone E', 2, 3, 1, 4, NULL),
(70, 54, 'Girone F', 1, 2, 4, 3, NULL),
(71, 54, 'Girone A', 1, 4, 2, 3, NULL),
(72, 36, 'Girone A', 1, 4, 3, 2, NULL),
(73, 15, 'Girone A', 1, 4, 3, 2, NULL),
(74, 15, 'Girone B', 1, 2, 4, 3, NULL),
(75, 36, 'Girone C', 4, 2, 3, 1, NULL),
(76, 51, 'Girone A', 2, 3, 4, 1, NULL),
(77, 51, 'Girone B', 3, 1, 2, 4, NULL),
(78, 51, 'Girone C', 3, 4, 2, 1, NULL),
(79, 51, 'Girone E', 2, 4, 1, 3, NULL),
(80, 51, 'Girone D', 2, 1, 3, 4, NULL),
(81, 51, 'Girone F', 2, 3, 4, 1, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `goal_veloce`
--

CREATE TABLE `goal_veloce` (
  `id` int(11) NOT NULL,
  `id_team` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `goal_veloce`
--

INSERT INTO `goal_veloce` (`id`, `id_team`) VALUES
(1, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `goal_veloce_bet`
--

CREATE TABLE `goal_veloce_bet` (
  `id` int(11) NOT NULL,
  `goal_veloce_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_team` int(11) NOT NULL,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `goal_veloce_bet`
--

INSERT INTO `goal_veloce_bet` (`id`, `goal_veloce_id`, `user_id`, `id_team`, `points`) VALUES
(7, 1, 32, 2, NULL),
(8, 1, 47, 4, NULL),
(9, 1, 29, 5, NULL),
(10, 1, 49, 2, NULL),
(11, 1, 54, 2, NULL),
(12, 1, 51, 14, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `id_team_1` int(11) NOT NULL,
  `id_team_2` int(11) NOT NULL,
  `fase` int(11) NOT NULL,
  `goal_team_1` int(11) DEFAULT NULL,
  `goal_team_2` int(11) DEFAULT NULL,
  `result` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `matches`
--

INSERT INTO `matches` (`id`, `date`, `id_team_1`, `id_team_2`, `fase`, `goal_team_1`, `goal_team_2`, `result`) VALUES
(8, '2024-06-14 21:00:00', 2, 7, 1, NULL, NULL, NULL),
(9, '2024-06-15 15:00:00', 8, 6, 1, NULL, NULL, NULL),
(10, '2024-06-15 18:00:00', 5, 3, 1, NULL, NULL, NULL),
(11, '2024-06-15 21:00:00', 1, 9, 1, NULL, NULL, NULL),
(12, '2024-06-16 15:00:00', 15, 14, 1, NULL, NULL, NULL),
(13, '2024-06-16 18:00:00', 10, 11, 1, NULL, NULL, NULL),
(14, '2024-06-16 21:00:00', 12, 13, 1, NULL, NULL, NULL),
(15, '2024-06-17 15:00:00', 20, 17, 1, NULL, NULL, NULL),
(16, '2024-06-17 18:00:00', 19, 18, 1, NULL, NULL, NULL),
(17, '2024-06-17 21:00:00', 16, 4, 1, NULL, NULL, NULL),
(18, '2024-06-18 18:00:00', 24, 23, 1, NULL, NULL, NULL),
(19, '2024-06-18 21:00:00', 21, 22, 1, NULL, NULL, NULL),
(20, '2024-06-19 15:00:00', 3, 9, 1, NULL, NULL, NULL),
(21, '2024-06-19 18:00:00', 2, 8, 1, NULL, NULL, NULL),
(22, '2024-06-19 21:00:00', 7, 6, 1, NULL, NULL, NULL),
(23, '2024-06-20 15:00:00', 10, 12, 1, NULL, NULL, NULL),
(24, '2024-06-20 18:00:00', 11, 13, 1, NULL, NULL, NULL),
(25, '2024-06-20 21:00:00', 5, 1, 1, NULL, NULL, NULL),
(26, '2024-06-21 15:00:00', 18, 17, 1, NULL, NULL, NULL),
(27, '2024-06-21 18:00:00', 15, 16, 1, NULL, NULL, NULL),
(28, '2024-06-21 21:00:00', 14, 4, 1, NULL, NULL, NULL),
(29, '2024-06-22 15:00:00', 23, 22, 1, NULL, NULL, NULL),
(30, '2024-06-22 18:00:00', 24, 21, 1, NULL, NULL, NULL),
(31, '2024-06-22 21:00:00', 19, 20, 1, NULL, NULL, NULL),
(32, '2024-06-23 21:00:00', 6, 2, 1, NULL, NULL, NULL),
(33, '2024-06-23 21:00:00', 7, 8, 1, NULL, NULL, NULL),
(34, '2024-06-24 21:00:00', 9, 5, 1, NULL, NULL, NULL),
(35, '2024-06-24 21:00:00', 3, 1, 1, NULL, NULL, NULL),
(36, '2024-06-25 18:00:00', 14, 16, 1, NULL, NULL, NULL),
(37, '2024-06-25 18:00:00', 4, 15, 1, NULL, NULL, NULL),
(38, '2024-06-25 21:00:00', 13, 10, 1, NULL, NULL, NULL),
(39, '2024-06-25 21:00:00', 11, 12, 1, NULL, NULL, NULL),
(40, '2024-06-26 18:00:00', 18, 20, 1, NULL, NULL, NULL),
(41, '2024-06-26 18:00:00', 17, 19, 1, NULL, NULL, NULL),
(42, '2024-06-26 21:00:00', 23, 21, 1, NULL, NULL, NULL),
(43, '2024-06-26 21:00:00', 22, 24, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `matches_bet`
--

CREATE TABLE `matches_bet` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `goal_team_1` int(11) NOT NULL,
  `goal_team_2` int(11) NOT NULL,
  `result` tinytext NOT NULL,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `matches_bet`
--

INSERT INTO `matches_bet` (`id`, `user_id`, `match_id`, `goal_team_1`, `goal_team_2`, `result`, `points`) VALUES
(64, 16, 8, 2, 0, '1', NULL),
(65, 16, 9, 1, 2, '2', NULL),
(66, 16, 21, 3, 0, '1', NULL),
(67, 16, 22, 1, 1, 'X', NULL),
(68, 16, 32, 1, 2, '2', NULL),
(69, 16, 33, 3, 1, '1', NULL),
(70, 16, 10, 1, 1, 'X', NULL),
(71, 16, 11, 2, 0, '1', NULL),
(72, 16, 20, 3, 1, '1', NULL),
(73, 16, 25, 2, 2, 'X', NULL),
(74, 16, 34, 0, 3, '2', NULL),
(75, 16, 35, 1, 2, '2', NULL),
(76, 16, 13, 0, 2, '2', NULL),
(77, 16, 14, 1, 3, '2', NULL),
(78, 16, 23, 0, 1, '2', NULL),
(79, 16, 24, 1, 3, '2', NULL),
(80, 16, 38, 4, 0, '1', NULL),
(81, 16, 39, 1, 1, 'X', NULL),
(82, 16, 12, 0, 1, '2', NULL),
(83, 16, 17, 1, 4, '2', NULL),
(84, 16, 27, 2, 0, '1', NULL),
(85, 16, 28, 2, 2, 'X', NULL),
(86, 16, 36, 2, 1, '1', NULL),
(87, 16, 37, 2, 0, '1', NULL),
(88, 16, 15, 0, 2, '2', NULL),
(89, 16, 16, 3, 0, '1', NULL),
(90, 16, 26, 1, 3, '2', NULL),
(91, 16, 31, 4, 0, '1', NULL),
(92, 16, 40, 1, 1, 'X', NULL),
(93, 16, 41, 1, 2, '2', NULL),
(94, 16, 18, 2, 1, '1', NULL),
(95, 16, 19, 3, 0, '1', NULL),
(96, 16, 29, 1, 1, 'X', NULL),
(97, 16, 30, 1, 2, '2', NULL),
(98, 16, 42, 0, 4, '2', NULL),
(99, 16, 43, 1, 3, '2', NULL),
(100, 21, 8, 3, 0, '1', NULL),
(101, 21, 9, 1, 2, '2', NULL),
(102, 21, 21, 4, 0, '1', NULL),
(103, 21, 22, 1, 0, '1', NULL),
(104, 21, 32, 1, 2, '2', NULL),
(105, 21, 33, 2, 0, '1', NULL),
(106, 21, 10, 2, 1, '1', NULL),
(107, 21, 11, 2, 0, '1', NULL),
(108, 21, 20, 3, 0, '1', NULL),
(109, 21, 25, 2, 0, '1', NULL),
(110, 21, 34, 1, 3, '2', NULL),
(111, 21, 35, 0, 1, '2', NULL),
(112, 21, 13, 1, 2, '2', NULL),
(113, 21, 14, 0, 2, '2', NULL),
(114, 21, 23, 1, 1, 'X', NULL),
(115, 21, 24, 1, 3, '2', NULL),
(116, 21, 38, 2, 0, '1', NULL),
(117, 21, 39, 1, 1, 'X', NULL),
(118, 21, 12, 1, 1, 'X', NULL),
(119, 21, 17, 1, 3, '2', NULL),
(120, 21, 27, 0, 0, 'X', NULL),
(121, 21, 28, 1, 2, '2', NULL),
(122, 21, 36, 2, 0, '1', NULL),
(123, 21, 37, 3, 0, '1', NULL),
(124, 21, 15, 0, 2, '2', NULL),
(125, 21, 16, 2, 0, '1', NULL),
(126, 21, 26, 1, 1, 'X', NULL),
(127, 21, 31, 3, 0, '1', NULL),
(128, 21, 40, 2, 0, '1', NULL),
(129, 21, 41, 1, 2, '2', NULL),
(130, 21, 18, 2, 0, '1', NULL),
(131, 21, 19, 2, 1, '1', NULL),
(132, 21, 29, 0, 2, '2', NULL),
(133, 21, 30, 1, 1, 'X', NULL),
(134, 21, 42, 0, 3, '2', NULL),
(135, 21, 43, 1, 2, '2', NULL),
(136, 26, 8, 2, 0, '1', NULL),
(137, 26, 9, 0, 1, '2', NULL),
(138, 31, 8, 3, 0, '1', NULL),
(139, 31, 9, 1, 2, '2', NULL),
(140, 31, 21, 2, 0, '1', NULL),
(141, 31, 22, 1, 1, 'X', NULL),
(142, 31, 32, 2, 2, 'X', NULL),
(143, 31, 33, 2, 1, '1', NULL),
(144, 31, 10, 3, 2, '1', NULL),
(145, 31, 11, 2, 0, '1', NULL),
(146, 31, 20, 3, 0, '1', NULL),
(147, 31, 25, 1, 1, 'X', NULL),
(148, 31, 34, 0, 4, '2', NULL),
(149, 31, 35, 2, 2, 'X', NULL),
(150, 31, 13, 1, 1, 'X', NULL),
(151, 31, 14, 0, 3, '2', NULL),
(152, 31, 23, 2, 0, '1', NULL),
(153, 31, 24, 1, 3, '2', NULL),
(154, 31, 38, 2, 1, '1', NULL),
(155, 31, 12, 2, 2, 'X', NULL),
(156, 31, 17, 1, 3, '2', NULL),
(157, 31, 27, 2, 2, 'X', NULL),
(158, 31, 28, 1, 1, 'X', NULL),
(159, 31, 36, 2, 0, '1', NULL),
(160, 31, 37, 1, 0, '1', NULL),
(161, 31, 15, 2, 0, '1', NULL),
(162, 31, 26, 2, 0, '1', NULL),
(163, 31, 16, 2, 1, '1', NULL),
(164, 31, 31, 3, 1, '1', NULL),
(165, 31, 40, 2, 1, '1', NULL),
(166, 31, 41, 1, 3, '2', NULL),
(167, 31, 18, 2, 2, 'X', NULL),
(168, 31, 30, 1, 3, '2', NULL),
(169, 31, 42, 1, 3, '2', NULL),
(170, 31, 19, 2, 0, '1', NULL),
(171, 31, 29, 0, 0, 'X', NULL),
(172, 31, 43, 1, 2, '2', NULL),
(173, 31, 39, 2, 1, '1', NULL),
(174, 32, 8, 3, 0, '1', NULL),
(175, 32, 9, 1, 1, 'X', NULL),
(176, 32, 21, 2, 0, '1', NULL),
(177, 32, 22, 1, 3, '2', NULL),
(178, 32, 32, 1, 2, '2', NULL),
(179, 32, 33, 2, 2, 'X', NULL),
(180, 32, 10, 3, 1, '1', NULL),
(181, 32, 11, 2, 0, '1', NULL),
(182, 32, 20, 2, 1, '1', NULL),
(183, 32, 25, 2, 1, '1', NULL),
(184, 32, 34, 0, 4, '2', NULL),
(185, 32, 35, 1, 3, '2', NULL),
(186, 32, 13, 1, 1, 'X', NULL),
(187, 32, 14, 2, 3, '2', NULL),
(188, 32, 23, 1, 3, '2', NULL),
(189, 32, 24, 1, 3, '2', NULL),
(190, 32, 38, 4, 0, '1', NULL),
(191, 32, 39, 2, 2, 'X', NULL),
(192, 32, 12, 1, 2, '2', NULL),
(193, 32, 17, 1, 2, '2', NULL),
(194, 32, 27, 2, 1, '1', NULL),
(195, 32, 28, 1, 3, '2', NULL),
(196, 32, 36, 3, 1, '1', NULL),
(197, 32, 37, 4, 1, '1', NULL),
(198, 32, 15, 0, 1, '2', NULL),
(199, 32, 16, 2, 0, '1', NULL),
(200, 32, 26, 1, 1, 'X', NULL),
(201, 32, 31, 4, 1, '1', NULL),
(202, 32, 40, 2, 2, 'X', NULL),
(203, 32, 41, 1, 2, '2', NULL),
(204, 32, 18, 2, 0, '1', NULL),
(205, 32, 19, 4, 0, '1', NULL),
(206, 32, 29, 1, 1, 'X', NULL),
(207, 32, 30, 1, 3, '2', NULL),
(208, 32, 42, 0, 3, '2', NULL),
(209, 32, 43, 2, 2, 'X', NULL),
(210, 25, 11, 1, 0, '1', NULL),
(211, 34, 8, 2, 1, '1', NULL),
(212, 34, 9, 2, 0, '1', NULL),
(213, 34, 21, 1, 1, 'X', NULL),
(214, 37, 8, 2, 0, '1', NULL),
(215, 37, 9, 1, 1, 'X', NULL),
(216, 37, 21, 3, 1, '1', NULL),
(217, 37, 22, 1, 2, '2', NULL),
(218, 37, 32, 0, 1, '2', NULL),
(219, 37, 33, 2, 0, '1', NULL),
(220, 37, 10, 1, 0, '1', NULL),
(221, 37, 11, 2, 0, '1', NULL),
(222, 37, 20, 3, 1, '1', NULL),
(223, 37, 34, 0, 4, '2', NULL),
(224, 37, 35, 0, 1, '2', NULL),
(225, 37, 25, 1, 1, 'X', NULL),
(226, 37, 12, 0, 2, '2', NULL),
(227, 37, 17, 0, 3, '2', NULL),
(228, 37, 27, 1, 0, '1', NULL),
(229, 37, 28, 1, 2, '2', NULL),
(230, 37, 36, 2, 1, '1', NULL),
(231, 37, 37, 1, 1, 'X', NULL),
(232, 37, 15, 1, 2, '2', NULL),
(233, 37, 16, 2, 0, '1', NULL),
(234, 25, 17, 0, 2, '2', NULL),
(235, 25, 16, 2, 0, '1', NULL),
(236, 25, 18, 2, 1, '1', NULL),
(237, 25, 8, 2, 0, '1', NULL),
(238, 25, 10, 2, 0, '1', NULL),
(239, 25, 25, 2, 1, '1', NULL),
(240, 25, 14, 0, 2, '2', NULL),
(241, 25, 27, 1, 0, '1', NULL),
(242, 25, 39, 1, 1, 'X', NULL),
(243, 25, 36, 3, 1, '1', NULL),
(244, 25, 28, 1, 2, '2', NULL),
(245, 25, 19, 2, 0, '1', NULL),
(246, 25, 30, 1, 3, '2', NULL),
(247, 25, 43, 1, 1, 'X', NULL),
(248, 25, 42, 0, 1, '2', NULL),
(249, 43, 8, 3, 0, '1', NULL),
(250, 43, 9, 1, 1, 'X', NULL),
(251, 43, 21, 2, 0, '1', NULL),
(252, 43, 22, 1, 2, '2', NULL),
(253, 43, 32, 1, 1, 'X', NULL),
(254, 43, 33, 1, 2, '2', NULL),
(255, 43, 10, 2, 1, '1', NULL),
(256, 43, 11, 3, 0, '1', NULL),
(257, 43, 20, 2, 0, '1', NULL),
(258, 43, 25, 2, 1, '1', NULL),
(259, 43, 34, 1, 3, '2', NULL),
(260, 43, 35, 1, 2, '2', NULL),
(261, 43, 13, 1, 2, '2', NULL),
(262, 43, 14, 0, 2, '2', NULL),
(263, 43, 23, 0, 2, '2', NULL),
(264, 43, 24, 1, 2, '2', NULL),
(265, 43, 38, 3, 0, '1', NULL),
(266, 43, 39, 1, 2, '2', NULL),
(267, 43, 12, 1, 2, '2', NULL),
(268, 43, 17, 0, 3, '2', NULL),
(269, 43, 27, 2, 1, '1', NULL),
(270, 43, 28, 1, 3, '2', NULL),
(271, 43, 36, 2, 0, '1', NULL),
(272, 43, 37, 1, 0, '1', NULL),
(273, 43, 15, 1, 1, 'X', NULL),
(274, 43, 16, 1, 0, '1', NULL),
(275, 43, 26, 0, 2, '2', NULL),
(276, 43, 31, 2, 1, '1', NULL),
(277, 43, 41, 1, 1, 'X', NULL),
(278, 43, 40, 0, 0, 'X', NULL),
(279, 43, 18, 2, 0, '1', NULL),
(280, 43, 19, 1, 1, 'X', NULL),
(281, 43, 29, 1, 1, 'X', NULL),
(282, 43, 30, 1, 3, '2', NULL),
(283, 43, 42, 0, 2, '2', NULL),
(284, 43, 43, 1, 2, '2', NULL),
(285, 47, 27, 1, 1, 'X', NULL),
(286, 47, 8, 3, 0, '1', NULL),
(287, 47, 9, 1, 2, '2', NULL),
(288, 47, 21, 5, 0, '1', NULL),
(289, 47, 22, 1, 2, '2', NULL),
(290, 47, 32, 0, 2, '2', NULL),
(291, 47, 33, 2, 1, '1', NULL),
(292, 47, 10, 2, 1, '1', NULL),
(293, 47, 11, 1, 0, '1', NULL),
(294, 47, 20, 2, 2, 'X', NULL),
(295, 47, 25, 1, 1, 'X', NULL),
(296, 47, 34, 1, 3, '2', NULL),
(297, 47, 35, 1, 2, '2', NULL),
(298, 47, 13, 1, 2, '2', NULL),
(299, 47, 14, 1, 3, '2', NULL),
(300, 47, 23, 1, 2, '2', NULL),
(301, 47, 24, 1, 3, '2', NULL),
(302, 47, 38, 3, 0, '1', NULL),
(303, 47, 39, 2, 1, '1', NULL),
(304, 47, 12, 0, 2, '2', NULL),
(305, 47, 17, 0, 2, '2', NULL),
(306, 47, 28, 1, 3, '2', NULL),
(307, 47, 36, 2, 1, '1', NULL),
(308, 47, 37, 3, 0, '1', NULL),
(309, 47, 15, 1, 1, 'X', NULL),
(310, 47, 16, 2, 0, '1', NULL),
(311, 47, 26, 1, 2, '2', NULL),
(312, 47, 31, 2, 1, '1', NULL),
(313, 47, 40, 0, 2, '2', NULL),
(314, 47, 41, 1, 1, 'X', NULL),
(315, 47, 18, 3, 0, '1', NULL),
(316, 47, 19, 2, 1, '1', NULL),
(317, 47, 29, 0, 2, '2', NULL),
(318, 47, 30, 3, 2, '1', NULL),
(319, 47, 42, 0, 3, '2', NULL),
(320, 47, 43, 1, 3, '2', NULL),
(321, 36, 8, 3, 0, '1', NULL),
(322, 36, 9, 1, 2, '2', NULL),
(323, 49, 8, 1, 0, '1', NULL),
(324, 49, 9, 1, 3, '2', NULL),
(325, 49, 21, 2, 0, '1', NULL),
(326, 49, 22, 1, 1, 'X', NULL),
(327, 49, 32, 1, 2, '2', NULL),
(328, 49, 33, 0, 1, '2', NULL),
(329, 49, 10, 3, 1, '1', NULL),
(330, 49, 11, 2, 0, '1', NULL),
(331, 49, 20, 2, 1, '1', NULL),
(332, 49, 25, 2, 1, '1', NULL),
(333, 49, 34, 0, 4, '2', NULL),
(334, 49, 35, 1, 2, '2', NULL),
(335, 50, 8, 3, 1, '1', NULL),
(336, 50, 9, 2, 2, 'X', NULL),
(337, 50, 21, 2, 1, '1', NULL),
(338, 50, 22, 0, 1, '2', NULL),
(339, 50, 32, 2, 3, '2', NULL),
(340, 50, 33, 0, 2, '2', NULL),
(341, 50, 10, 2, 1, '1', NULL),
(342, 50, 11, 1, 0, '1', NULL),
(343, 50, 20, 1, 1, 'X', NULL),
(344, 50, 25, 2, 1, '1', NULL),
(345, 50, 34, 0, 2, '2', NULL),
(346, 50, 35, 1, 1, 'X', NULL),
(347, 50, 13, 1, 2, '2', NULL),
(348, 50, 14, 1, 3, '2', NULL),
(349, 50, 23, 0, 0, 'X', NULL),
(350, 50, 24, 1, 2, '2', NULL),
(351, 50, 38, 3, 0, '1', NULL),
(352, 50, 39, 2, 2, 'X', NULL),
(353, 50, 28, 2, 2, 'X', NULL),
(354, 50, 27, 1, 1, 'X', NULL),
(355, 50, 12, 1, 2, '2', NULL),
(356, 50, 17, 1, 2, '2', NULL),
(357, 50, 36, 1, 2, '2', NULL),
(358, 50, 37, 3, 1, '1', NULL),
(359, 50, 15, 1, 2, '2', NULL),
(360, 50, 16, 2, 0, '1', NULL),
(361, 50, 26, 0, 1, '2', NULL),
(362, 50, 31, 3, 0, '1', NULL),
(363, 50, 40, 1, 1, 'X', NULL),
(364, 50, 41, 1, 2, '2', NULL),
(365, 50, 18, 2, 0, '1', NULL),
(366, 50, 19, 2, 1, '1', NULL),
(367, 50, 29, 1, 2, '2', NULL),
(368, 50, 30, 1, 1, 'X', NULL),
(369, 50, 42, 0, 3, '2', NULL),
(370, 50, 43, 1, 1, 'X', NULL),
(371, 25, 20, 1, 1, 'X', NULL),
(372, 25, 34, 0, 2, '2', NULL),
(373, 25, 35, 1, 1, 'X', NULL),
(374, 29, 8, 2, 0, '1', NULL),
(375, 29, 9, 0, 1, '2', NULL),
(376, 29, 21, 3, 0, '1', NULL),
(377, 29, 22, 1, 2, '2', NULL),
(378, 29, 32, 1, 3, '2', NULL),
(379, 29, 33, 0, 1, '2', NULL),
(380, 29, 10, 2, 0, '1', NULL),
(381, 29, 11, 3, 0, '1', NULL),
(382, 29, 20, 2, 0, '1', NULL),
(383, 29, 25, 2, 1, '1', NULL),
(384, 29, 34, 0, 3, '2', NULL),
(385, 29, 35, 1, 2, '2', NULL),
(386, 26, 21, 2, 1, '1', NULL),
(387, 26, 22, 1, 1, 'X', NULL),
(388, 26, 32, 0, 1, '2', NULL),
(389, 26, 33, 2, 2, 'X', NULL),
(390, 26, 10, 2, 1, '1', NULL),
(391, 26, 11, 2, 0, '1', NULL),
(392, 26, 20, 2, 0, '1', NULL),
(393, 26, 25, 1, 1, 'X', NULL),
(394, 26, 34, 0, 3, '2', NULL),
(395, 26, 35, 1, 1, 'X', NULL),
(396, 26, 13, 0, 1, '2', NULL),
(397, 26, 14, 0, 2, '2', NULL),
(398, 26, 23, 1, 2, '2', NULL),
(399, 26, 24, 1, 2, '2', NULL),
(400, 26, 38, 3, 0, '1', NULL),
(401, 26, 39, 1, 1, 'X', NULL),
(402, 26, 12, 1, 2, '2', NULL),
(403, 26, 17, 1, 2, '2', NULL),
(404, 26, 27, 1, 1, 'X', NULL),
(405, 26, 28, 1, 2, '2', NULL),
(406, 26, 36, 2, 1, '1', NULL),
(407, 26, 37, 2, 0, '1', NULL),
(408, 26, 15, 0, 1, '2', NULL),
(409, 26, 16, 3, 1, '1', NULL),
(410, 26, 26, 1, 2, '2', NULL),
(411, 26, 31, 3, 0, '1', NULL),
(412, 26, 40, 1, 1, 'X', NULL),
(413, 26, 41, 1, 2, '2', NULL),
(414, 26, 18, 3, 1, '1', NULL),
(415, 26, 19, 2, 0, '1', NULL),
(416, 26, 29, 1, 2, '2', NULL),
(417, 26, 30, 1, 2, '2', NULL),
(418, 26, 42, 0, 3, '2', NULL),
(419, 26, 43, 0, 2, '2', NULL),
(420, 29, 13, 0, 1, '2', NULL),
(421, 29, 14, 0, 2, '2', NULL),
(422, 29, 23, 1, 2, '2', NULL),
(423, 29, 24, 1, 2, '2', NULL),
(424, 29, 38, 2, 0, '1', NULL),
(425, 29, 39, 1, 0, '1', NULL),
(426, 29, 12, 1, 2, '2', NULL),
(427, 29, 17, 0, 2, '2', NULL),
(428, 29, 27, 0, 1, '2', NULL),
(429, 29, 28, 1, 3, '2', NULL),
(430, 29, 36, 2, 1, '1', NULL),
(431, 29, 37, 3, 0, '1', NULL),
(432, 29, 15, 0, 2, '2', NULL),
(433, 29, 16, 3, 0, '1', NULL),
(434, 29, 26, 0, 2, '2', NULL),
(435, 29, 41, 1, 4, '2', NULL),
(436, 29, 31, 3, 1, '1', NULL),
(437, 29, 40, 0, 1, '2', NULL),
(438, 29, 18, 2, 0, '1', NULL),
(439, 29, 19, 3, 0, '1', NULL),
(440, 29, 29, 1, 1, 'X', NULL),
(441, 29, 30, 1, 3, '2', NULL),
(442, 29, 42, 0, 2, '2', NULL),
(443, 29, 43, 1, 3, '2', NULL),
(444, 49, 13, 0, 1, '2', NULL),
(445, 49, 14, 1, 2, '2', NULL),
(446, 49, 23, 0, 2, '2', NULL),
(447, 49, 24, 0, 2, '2', NULL),
(448, 49, 38, 1, 0, '1', NULL),
(449, 49, 39, 1, 3, '2', NULL),
(450, 49, 12, 1, 2, '2', NULL),
(451, 49, 17, 0, 2, '2', NULL),
(452, 49, 27, 1, 1, 'X', NULL),
(453, 49, 28, 1, 3, '2', NULL),
(454, 49, 36, 1, 0, '1', NULL),
(455, 49, 37, 2, 0, '1', NULL),
(456, 49, 15, 0, 2, '2', NULL),
(457, 49, 16, 3, 0, '1', NULL),
(458, 49, 26, 0, 1, '2', NULL),
(459, 49, 31, 2, 1, '1', NULL),
(460, 49, 40, 1, 0, '1', NULL),
(461, 49, 41, 1, 3, '2', NULL),
(462, 49, 18, 2, 0, '1', NULL),
(463, 49, 19, 4, 0, '1', NULL),
(464, 49, 29, 1, 0, '1', NULL),
(465, 49, 30, 1, 2, '2', NULL),
(466, 49, 42, 0, 3, '2', NULL),
(467, 49, 43, 0, 1, '2', NULL),
(468, 17, 8, 2, 0, '1', NULL),
(469, 17, 9, 1, 1, 'X', NULL),
(470, 54, 8, 2, 0, '1', NULL),
(471, 54, 9, 1, 1, 'X', NULL),
(472, 54, 21, 2, 1, '1', NULL),
(473, 54, 22, 1, 1, 'X', NULL),
(474, 54, 32, 1, 2, '2', NULL),
(475, 54, 33, 0, 1, '2', NULL),
(476, 54, 10, 2, 1, '1', NULL),
(477, 54, 11, 2, 0, '1', NULL),
(478, 54, 20, 2, 0, '1', NULL),
(479, 54, 25, 1, 1, 'X', NULL),
(480, 54, 34, 0, 2, '2', NULL),
(481, 54, 35, 1, 1, 'X', NULL),
(482, 54, 13, 1, 1, 'X', NULL),
(483, 54, 14, 1, 2, '2', NULL),
(484, 54, 23, 2, 2, 'X', NULL),
(485, 54, 24, 1, 2, '2', NULL),
(486, 54, 38, 3, 1, '1', NULL),
(487, 54, 39, 2, 2, 'X', NULL),
(488, 54, 12, 1, 2, '2', NULL),
(489, 54, 17, 1, 2, '2', NULL),
(490, 54, 27, 1, 1, 'X', NULL),
(491, 54, 28, 2, 2, 'X', NULL),
(492, 54, 36, 2, 1, '1', NULL),
(493, 54, 37, 2, 0, '1', NULL),
(494, 54, 15, 1, 2, '2', NULL),
(495, 54, 16, 2, 1, '1', NULL),
(496, 54, 26, 1, 1, 'X', NULL),
(497, 54, 31, 3, 1, '1', NULL),
(498, 54, 40, 0, 0, 'X', NULL),
(499, 54, 41, 1, 1, 'X', NULL),
(500, 54, 18, 2, 1, '1', NULL),
(501, 54, 19, 2, 1, '1', NULL),
(502, 54, 29, 1, 1, 'X', NULL),
(503, 54, 30, 1, 2, '2', NULL),
(504, 54, 42, 0, 3, '2', NULL),
(505, 54, 43, 2, 1, '1', NULL),
(506, 38, 8, 3, 0, '1', NULL),
(507, 38, 9, 1, 1, 'X', NULL),
(508, 38, 21, 2, 1, '1', NULL),
(509, 38, 22, 1, 1, 'X', NULL),
(510, 38, 32, 0, 0, 'X', NULL),
(511, 38, 33, 1, 2, '2', NULL),
(512, 15, 8, 2, 0, '1', NULL),
(513, 15, 9, 0, 2, '2', NULL),
(514, 15, 21, 3, 1, '1', NULL),
(515, 15, 22, 0, 3, '2', NULL),
(516, 15, 32, 0, 1, '2', NULL),
(517, 15, 33, 2, 2, 'X', NULL),
(518, 36, 21, 2, 0, '1', NULL),
(519, 36, 22, 1, 2, '2', NULL),
(520, 36, 32, 1, 1, 'X', NULL),
(521, 36, 33, 2, 3, '2', NULL),
(522, 15, 10, 1, 0, '1', NULL),
(523, 15, 11, 1, 4, '2', NULL),
(524, 15, 20, 4, 1, '1', NULL),
(525, 15, 25, 3, 0, '1', NULL),
(526, 15, 34, 0, 2, '2', NULL),
(527, 15, 35, 3, 1, '1', NULL),
(528, 36, 13, 0, 2, '2', NULL),
(529, 36, 14, 1, 2, '2', NULL),
(530, 36, 23, 1, 3, '2', NULL),
(531, 36, 24, 2, 2, 'X', NULL),
(532, 36, 38, 3, 0, '1', NULL),
(533, 36, 39, 1, 1, 'X', NULL),
(534, 25, 38, 4, 0, '1', NULL),
(535, 25, 24, 1, 2, '2', NULL),
(536, 25, 23, 0, 2, '2', NULL),
(537, 25, 13, 0, 1, '2', NULL),
(538, 25, 22, 0, 2, '2', NULL),
(539, 25, 9, 1, 1, 'X', NULL),
(540, 25, 21, 2, 1, '1', NULL),
(541, 25, 33, 0, 1, '2', NULL),
(542, 25, 12, 1, 2, '2', NULL),
(543, 25, 32, 1, 2, '2', NULL),
(544, 25, 15, 0, 1, '2', NULL),
(545, 25, 26, 0, 1, '2', NULL),
(546, 25, 31, 2, 0, '1', NULL),
(547, 25, 41, 1, 3, '2', NULL),
(548, 25, 40, 1, 1, 'X', NULL),
(549, 25, 29, 0, 2, '2', NULL),
(550, 25, 37, 1, 0, '1', NULL),
(551, 51, 8, 2, 1, '1', NULL),
(552, 51, 9, 0, 1, '2', NULL),
(553, 51, 21, 5, 1, '1', NULL),
(554, 51, 22, 0, 3, '2', NULL),
(555, 51, 32, 1, 0, '1', NULL),
(556, 51, 33, 2, 2, 'X', NULL),
(557, 51, 10, 1, 1, 'X', NULL),
(558, 51, 11, 1, 0, '1', NULL),
(559, 51, 20, 3, 1, '1', NULL),
(560, 51, 25, 1, 1, 'X', NULL),
(561, 51, 34, 0, 2, '2', NULL),
(562, 51, 35, 1, 1, 'X', NULL),
(563, 51, 13, 2, 1, '1', NULL),
(564, 51, 14, 0, 4, '2', NULL),
(565, 51, 23, 1, 2, '2', NULL),
(566, 51, 24, 1, 3, '2', NULL),
(567, 51, 38, 1, 0, '1', NULL),
(568, 51, 39, 2, 2, 'X', NULL),
(569, 51, 12, 2, 3, '2', NULL),
(570, 51, 17, 1, 3, '2', NULL),
(571, 51, 27, 1, 1, 'X', NULL),
(572, 51, 28, 0, 0, 'X', NULL),
(573, 51, 36, 3, 2, '1', NULL),
(574, 51, 37, 3, 1, '1', NULL),
(575, 51, 15, 1, 1, 'X', NULL),
(576, 51, 16, 4, 2, '1', NULL),
(577, 51, 26, 0, 1, '2', NULL),
(578, 51, 31, 2, 1, '1', NULL),
(579, 51, 40, 1, 4, '2', NULL),
(580, 51, 41, 3, 3, 'X', NULL),
(581, 51, 18, 3, 1, '1', NULL),
(582, 51, 19, 2, 0, '1', NULL),
(583, 51, 29, 1, 1, 'X', NULL),
(584, 51, 30, 2, 1, '1', NULL),
(585, 51, 42, 2, 5, '2', NULL),
(586, 51, 43, 2, 3, '2', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `matches_fin`
--

CREATE TABLE `matches_fin` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `id_team_1` int(11) DEFAULT NULL,
  `id_team_2` int(11) DEFAULT NULL,
  `n_match` int(11) NOT NULL,
  `fase` int(11) NOT NULL,
  `goal_team_1` int(11) DEFAULT NULL,
  `goal_team_2` int(11) DEFAULT NULL,
  `result` text DEFAULT NULL,
  `final_result` text DEFAULT NULL,
  `des_1` text NOT NULL,
  `des_2` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `matches_fin`
--

INSERT INTO `matches_fin` (`id`, `date`, `id_team_1`, `id_team_2`, `n_match`, `fase`, `goal_team_1`, `goal_team_2`, `result`, `final_result`, `des_1`, `des_2`) VALUES
(6, '2024-06-30 21:00:00', NULL, NULL, 39, 2, NULL, NULL, NULL, NULL, '1B', '3A/D/E/F'),
(7, '2024-06-29 21:00:00', NULL, NULL, 37, 2, NULL, NULL, NULL, '1', '1A', '2C'),
(8, '2024-07-01 21:00:00', NULL, NULL, 41, 2, NULL, NULL, NULL, '', '1F', '3A/B/C'),
(9, '2024-07-01 18:00:00', NULL, NULL, 42, 2, NULL, NULL, NULL, '', '2D', '2E'),
(10, '2024-07-02 18:00:00', NULL, NULL, 43, 2, NULL, NULL, NULL, '', '1E', '3A/B/C/D'),
(11, '2024-07-02 21:00:00', NULL, NULL, 44, 2, NULL, NULL, NULL, '', '1D', '2F'),
(12, '2024-06-30 18:00:00', NULL, NULL, 40, 2, NULL, NULL, NULL, NULL, '1C', '3D/E/F'),
(13, '2024-06-29 18:00:00', NULL, NULL, 38, 2, NULL, NULL, NULL, NULL, '2A', '2B'),
(14, '2024-07-05 18:00:00', NULL, NULL, 45, 3, NULL, NULL, NULL, NULL, 'W39', 'W37'),
(15, '2024-07-05 21:00:00', NULL, NULL, 46, 3, NULL, NULL, NULL, '', 'W41', 'W42'),
(16, '2024-07-06 21:00:00', NULL, NULL, 47, 3, NULL, NULL, NULL, '', 'W43', 'W44'),
(17, '2024-07-06 18:00:00', NULL, NULL, 48, 3, NULL, NULL, NULL, '', 'W40', 'W38'),
(18, '2024-07-09 21:00:00', NULL, NULL, 49, 4, NULL, NULL, NULL, '', 'W45', 'W46'),
(19, '2024-07-10 21:00:00', NULL, NULL, 50, 4, NULL, NULL, NULL, '', 'W47', 'W48'),
(20, '2024-07-14 21:00:00', NULL, NULL, 51, 5, NULL, NULL, NULL, NULL, 'W49', 'W50');

-- --------------------------------------------------------

--
-- Struttura della tabella `matches_fin_bet`
--

CREATE TABLE `matches_fin_bet` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `id_team_1` int(11) DEFAULT NULL,
  `id_team_2` int(11) DEFAULT NULL,
  `goal_team_1` int(11) DEFAULT NULL,
  `goal_team_2` int(11) DEFAULT NULL,
  `result` text DEFAULT NULL,
  `final_result` text DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `bonus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `matches_fin_bet`
--

INSERT INTO `matches_fin_bet` (`id`, `user_id`, `match_id`, `id_team_1`, `id_team_2`, `goal_team_1`, `goal_team_2`, `result`, `final_result`, `points`, `bonus`) VALUES
(59, 32, 7, 2, 12, 2, 0, '1', NULL, NULL, NULL),
(60, 32, 14, 5, 2, 2, 3, '2', NULL, NULL, NULL),
(61, 32, 13, 6, 1, 1, 2, '2', NULL, NULL, NULL),
(62, 32, 17, 13, 1, 1, 1, 'X', '2', NULL, NULL),
(63, 32, 6, 5, 8, 2, 1, '1', NULL, NULL, NULL),
(64, 32, 12, 13, 15, 4, 1, '1', NULL, NULL, NULL),
(65, 32, 10, 19, 3, 2, 1, '1', NULL, NULL, NULL),
(66, 32, 16, 19, 4, 1, 3, '2', NULL, NULL, NULL),
(67, 32, 8, 21, 11, 1, 1, 'X', '1', NULL, NULL),
(68, 32, 15, 21, 14, 3, 0, '1', NULL, NULL, NULL),
(69, 32, 9, 14, 17, 2, 2, 'X', '1', NULL, NULL),
(70, 32, 11, 4, 24, 4, 0, '1', NULL, NULL, NULL),
(71, 32, 18, 2, 21, 2, 0, '1', NULL, NULL, NULL),
(72, 32, 19, 4, 1, 3, 0, '1', NULL, NULL, NULL),
(73, 32, 20, 2, 4, 2, 2, 'X', '2', NULL, NULL),
(74, 16, 7, 2, 12, 1, 0, '1', NULL, NULL, NULL),
(75, 16, 14, 1, 2, 1, 1, 'X', '1', NULL, NULL),
(76, 16, 13, 6, 5, 0, 2, '2', NULL, NULL, NULL),
(77, 16, 17, 13, 5, 2, 2, 'X', '1', NULL, NULL),
(78, 16, 6, 1, 7, 2, 0, '1', NULL, NULL, NULL),
(79, 16, 12, 13, 15, 3, 1, '1', NULL, NULL, NULL),
(80, 16, 8, 21, 3, 2, 1, '1', NULL, NULL, NULL),
(81, 16, 15, 21, 14, 1, 0, '1', NULL, NULL, NULL),
(82, 16, 9, 14, 17, 2, 1, '1', NULL, NULL, NULL),
(83, 16, 10, 19, 11, 1, 0, '1', NULL, NULL, NULL),
(84, 16, 16, 19, 4, 0, 2, '2', NULL, NULL, NULL),
(85, 16, 11, 4, 24, 3, 0, '1', NULL, NULL, NULL),
(86, 16, 18, 1, 21, 2, 1, '1', NULL, NULL, NULL),
(87, 16, 19, 4, 13, 2, 1, '1', NULL, NULL, NULL),
(88, 16, 20, 1, 4, 2, 2, 'X', '1', NULL, NULL),
(89, 15, 7, 2, 9, 2, 4, '2', NULL, NULL, NULL),
(90, 15, 14, NULL, 9, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 25, 7, 2, 12, 2, 0, '1', NULL, NULL, NULL),
(92, 25, 14, 5, 2, 1, 1, 'X', '2', NULL, NULL),
(93, 25, 11, 4, 24, 2, 0, '1', NULL, NULL, NULL),
(94, 25, 16, 19, 4, 1, 3, '2', NULL, NULL, NULL),
(95, 47, 7, 2, 11, 3, 1, '1', NULL, NULL, NULL),
(96, 47, 14, 5, 2, 1, 3, '2', NULL, NULL, NULL),
(97, 47, 13, 6, 1, 0, 2, '2', NULL, NULL, NULL),
(98, 47, 17, 13, 1, 1, 1, 'X', '1', NULL, NULL),
(99, 47, 9, 14, 17, 3, 1, '1', NULL, NULL, NULL),
(100, 47, 15, 24, 14, 3, 2, '1', NULL, NULL, NULL),
(101, 47, 6, 5, 20, 3, 1, '1', NULL, NULL, NULL),
(102, 47, 11, 4, 21, 3, 1, '1', NULL, NULL, NULL),
(103, 47, 16, 19, 4, 1, 3, '2', NULL, NULL, NULL),
(104, 47, 12, 13, 22, 3, 0, '1', NULL, NULL, NULL),
(105, 47, 8, 24, 12, 2, 1, '1', NULL, NULL, NULL),
(106, 47, 10, 19, 7, 2, 0, '1', NULL, NULL, NULL),
(107, 47, 18, 2, 24, 2, 0, '1', NULL, NULL, NULL),
(108, 47, 19, 4, 13, 2, 2, 'X', '1', NULL, NULL),
(109, 47, 20, 2, 4, 1, 3, '2', NULL, NULL, NULL),
(110, 29, 7, 2, 11, 2, 0, '1', NULL, NULL, NULL),
(111, 29, 14, 5, 2, 2, 1, '1', NULL, NULL, NULL),
(112, 29, 13, 6, 1, 1, 2, '2', NULL, NULL, NULL),
(113, 29, 17, 13, 1, 1, 2, '2', NULL, NULL, NULL),
(114, 29, 6, 5, 8, 3, 0, '1', NULL, NULL, NULL),
(115, 29, 12, 13, 16, 2, 1, '1', NULL, NULL, NULL),
(116, 29, 8, 21, 12, 1, 0, '1', NULL, NULL, NULL),
(117, 29, 15, 21, 14, 1, 0, '1', NULL, NULL, NULL),
(118, 29, 9, 14, 17, 3, 1, '1', NULL, NULL, NULL),
(119, 29, 10, 19, 3, 2, 0, '1', NULL, NULL, NULL),
(120, 29, 16, 19, 4, 1, 3, '2', NULL, NULL, NULL),
(121, 29, 11, 4, 24, 4, 1, '1', NULL, NULL, NULL),
(122, 29, 18, 5, 21, 1, 0, '1', NULL, NULL, NULL),
(123, 29, 19, 4, 1, 2, 0, '1', NULL, NULL, NULL),
(124, 29, 20, 5, 4, 2, 1, '1', NULL, NULL, NULL),
(125, 49, 7, 2, 12, 2, 1, '1', NULL, NULL, NULL),
(126, 49, 14, 5, 2, 2, 1, '1', NULL, NULL, NULL),
(127, 49, 13, 6, 1, 0, 2, '2', NULL, NULL, NULL),
(128, 49, 17, 13, 1, 0, 2, '2', NULL, NULL, NULL),
(129, 49, 6, 5, 8, 3, 0, '1', NULL, NULL, NULL),
(130, 49, 12, 13, 18, 2, 0, '1', NULL, NULL, NULL),
(131, 49, 8, 21, 11, 1, 0, '1', NULL, NULL, NULL),
(132, 49, 15, 21, 14, 1, 0, '1', NULL, NULL, NULL),
(133, 49, 9, 14, 17, 2, 1, '1', NULL, NULL, NULL),
(134, 49, 10, 19, 3, 3, 1, '1', NULL, NULL, NULL),
(135, 49, 16, 19, 4, 1, 2, '2', NULL, NULL, NULL),
(136, 49, 11, 4, 24, 3, 2, '1', NULL, NULL, NULL),
(137, 49, 18, 5, 21, 2, 1, '1', NULL, NULL, NULL),
(138, 49, 19, 4, 1, 3, 1, '1', NULL, NULL, NULL),
(139, 49, 20, 5, 4, 1, 2, '2', NULL, NULL, NULL),
(140, 54, 7, 2, 12, 2, 1, '1', NULL, NULL, NULL),
(141, 54, 14, 5, 2, 2, 2, 'X', '2', NULL, NULL),
(142, 54, 13, 6, 1, 1, 1, 'X', '2', NULL, NULL),
(143, 54, 17, 13, 1, 2, 1, '1', NULL, NULL, NULL),
(144, 54, 6, 5, 24, 2, 1, '1', NULL, NULL, NULL),
(145, 54, 12, 13, 16, 2, 0, '1', NULL, NULL, NULL),
(146, 54, 8, 21, 3, 1, 1, 'X', '1', NULL, NULL),
(147, 54, 15, 21, 17, 2, 1, '1', NULL, NULL, NULL),
(148, 54, 9, 14, 17, 1, 1, 'X', '2', NULL, NULL),
(149, 54, 10, 19, 11, 2, 1, '1', NULL, NULL, NULL),
(150, 54, 16, 19, 4, 1, 2, '2', NULL, NULL, NULL),
(151, 54, 11, 4, 22, 3, 1, '1', NULL, NULL, NULL),
(152, 54, 18, 2, 21, 2, 1, '1', NULL, NULL, NULL),
(153, 54, 19, 4, 13, 2, 1, '1', NULL, NULL, NULL),
(154, 54, 20, 2, 4, 1, 2, '2', NULL, NULL, NULL),
(155, 50, 7, 2, 11, 3, 1, '1', NULL, NULL, NULL),
(156, 50, 14, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL),
(157, 50, 13, 8, 1, 0, 1, '2', NULL, NULL, NULL),
(158, 50, 17, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(159, 50, 9, 16, 17, 1, 1, 'X', '1', NULL, NULL),
(160, 50, 15, NULL, 16, NULL, NULL, NULL, NULL, NULL, NULL),
(161, 50, 11, 4, 24, 3, 1, '1', NULL, NULL, NULL),
(162, 50, 16, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL),
(163, 25, 13, 6, 1, 0, 1, '2', NULL, NULL, NULL),
(164, 25, 17, 13, 1, 2, 0, '1', NULL, NULL, NULL),
(165, 25, 9, 14, 17, 2, 0, '1', NULL, NULL, NULL),
(166, 25, 15, 21, 14, 2, 2, 'X', '2', NULL, NULL),
(167, 25, 6, 5, 22, 2, 0, '1', NULL, NULL, NULL),
(168, 25, 12, 13, 15, 3, 1, '1', NULL, NULL, NULL),
(169, 25, 8, 21, 8, 2, 1, '1', NULL, NULL, NULL),
(170, 25, 10, 19, 11, 1, 1, 'X', '1', NULL, NULL),
(171, 25, 19, 4, 13, 1, 2, '2', NULL, NULL, NULL),
(172, 25, 18, 2, 14, 1, 0, '1', NULL, NULL, NULL),
(173, 25, 20, 2, 13, 1, 2, '2', NULL, NULL, NULL),
(174, 51, 7, 6, 12, 1, 1, 'X', '2', NULL, NULL),
(175, 51, 14, 3, 12, 1, 1, 'X', '2', NULL, NULL),
(176, 51, 13, 2, 1, 2, 0, '1', NULL, NULL, NULL),
(177, 51, 17, 13, 2, 1, 1, 'X', '2', NULL, NULL),
(178, 51, 6, 3, 15, 3, 1, '1', NULL, NULL, NULL),
(179, 51, 12, 13, 22, 3, 2, '1', NULL, NULL, NULL),
(180, 51, 8, 24, 5, 2, 2, 'X', '2', NULL, NULL),
(181, 51, 15, 5, 14, 4, 1, '1', NULL, NULL, NULL),
(182, 51, 9, 14, 17, 4, 1, '1', NULL, NULL, NULL),
(183, 51, 10, 19, 7, 3, 0, '1', NULL, NULL, NULL),
(184, 51, 16, 19, 4, 3, 3, 'X', '2', NULL, NULL),
(185, 51, 11, 4, 21, 5, 2, '1', NULL, NULL, NULL),
(186, 51, 18, 12, 5, 0, 2, '2', NULL, NULL, NULL),
(187, 51, 19, 4, 2, 1, 3, '2', NULL, NULL, NULL),
(188, 51, 20, 5, 2, 2, 3, '2', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `iso` text NOT NULL,
  `girone` text NOT NULL,
  `breve` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `teams`
--

INSERT INTO `teams` (`id`, `name`, `iso`, `girone`, `breve`) VALUES
(1, 'Italia', 'IT', 'B', 'ITA'),
(2, 'Germania', 'DE', 'A', 'GER'),
(3, 'Croazia', 'HR', 'B', 'CRO'),
(4, 'Francia', 'FR', 'D', 'FRA'),
(5, 'Spagna', 'ES', 'B', 'SPA'),
(6, 'Svizzera', 'CH', 'A', 'SVI'),
(7, 'Scozia', 'GB-SCT', 'A', 'SCO'),
(8, 'Ungheria', 'HU', 'A', 'UNG'),
(9, 'Albania', 'AL', 'B', 'ALB'),
(10, 'Slovenia', 'SI', 'C', 'SLO'),
(11, 'Danimarca', 'DK', 'C', 'DAN'),
(12, 'Serbia', 'RS', 'C', 'SRB'),
(13, 'Inghilterra', 'GB-ENG', 'C', 'ING'),
(14, 'Olanda', 'NL', 'D', 'OLA'),
(15, 'Polonia', 'PL', 'D', 'POL'),
(16, 'Austria', 'AT', 'D', 'AUS'),
(17, 'Ucraina', 'UA', 'E', 'UCR'),
(18, 'Slovacchia', 'SK', 'E', 'SLK'),
(19, 'Belgio', 'BE', 'E', 'BEL'),
(20, 'Romania', 'RO', 'E', 'ROM'),
(21, 'Portogallo', 'PT', 'F', 'POR'),
(22, 'Rep. Ceca', 'CZ', 'F', 'RPC'),
(23, 'Georgia', 'GE', 'F', 'GEO'),
(24, 'Turchia', 'TR', 'F', 'TUR');

-- --------------------------------------------------------

--
-- Struttura della tabella `team_rivelaz`
--

CREATE TABLE `team_rivelaz` (
  `id` int(11) NOT NULL,
  `id_team` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `team_rivelaz`
--

INSERT INTO `team_rivelaz` (`id`, `id_team`) VALUES
(1, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `team_rivelaz_bet`
--

CREATE TABLE `team_rivelaz_bet` (
  `id` int(11) NOT NULL,
  `team_rivelaz_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_team` int(11) NOT NULL,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `team_rivelaz_bet`
--

INSERT INTO `team_rivelaz_bet` (`id`, `team_rivelaz_id`, `user_id`, `id_team`, `points`) VALUES
(8, 1, 31, 14, NULL),
(9, 1, 32, 8, NULL),
(10, 1, 16, 12, NULL),
(11, 1, 47, 24, NULL),
(12, 1, 29, 5, NULL),
(13, 1, 49, 1, NULL),
(14, 1, 54, 17, NULL),
(15, 1, 51, 12, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `extra_info` text NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `admin`, `extra_info`, `isActive`) VALUES
(1, 'matteo berlato', 'matteoberla02@gmail.com', '$2y$10$YYh0z4rnr3U0N3F0qaNUTuuSlFWV/2hTgIzLYAvgbMXI8IiU0ST3m', 1, 'VGxtc3JuNjkw', 1),
(15, 'MÃ¼ller', '3397842912', '$2y$10$q0y5UPyeRjRfd5rFFjiWb.Sh5eJ6kgULuXWq8ZIubU9a/HU0xQsIK', 1, 'ZXVybzIwMjQ=', 0),
(16, 'NicCaso99', '3398943453', '$2y$10$IQk0bMAXqNmFUj8TlVpxLOiR58MRklVovtDYbvutMhydRmY38.FHC', 0, 'Ym9ibWFybGV5MjY5OQ==', 0),
(17, 'Luca IlPort1ere', '3477232537', '$2y$10$YW7bGNUYbJ2YoVPDS2/45uLjnC2CuUjxZ85RQ1xSHqAPzwDvdRKIq', 0, 'SWxQb3J0MWVyZQ==', 0),
(19, 'jraffa', '3711984506', '$2y$10$95oOyF.niNXUVrSNKjcEzOH6vgzJU.rxo49t1XFXKK37PoI3oo/E.', 0, 'Z2lyYWZmYTA2', 1),
(20, 'Mannero', '3343175918', '$2y$10$DtyxSVa1Naq.Lm0lyeKipeTJUUCksUftdWfYgJdS1TCHOhR3WrK6y', 0, 'VGxtc3JuNjkw', 0),
(21, 'olly_nclusive team', '3336103117', '$2y$10$T42sZp.K20NXKqyUhuPwJ.K.teP9cQjZI2JCfdDs5svSCUWQwiPYa', 0, 'anV2ZW50dXMwMw==', 0),
(22, 'Favati', '3771462648', '$2y$10$c6l92aw1DTa8NVT9Y0ujBukgdfe3NX/5deGqH9diRVoC7IKZgFvUy', 0, 'ZmF2YXRpNjc=', 0),
(23, 'babuzzodj', '3500030001', '$2y$10$twRZTwwBez5wzZdKbO0dR.mLGJE1FumaNaAoyb7p4gOn/e5w7CTS.', 0, 'QmFidTIwMDM=', 0),
(24, 'GioERfutbol', '3737467065', '$2y$10$SswRWvJ.8B6kta8Zbe6w..3kPtE07IebM5paroDMohcofLkdqOkhe', 0, 'R2lvc3VlZWxlbmEy', 0),
(25, 'CAMPARES', '3484046831', '$2y$10$E9MzSj10SJIBZb8SRzJvz.NmPUg4SSIIQNCyo3JFLnKjz4oJTIxcy', 0, 'MTIzU3RlbGxhPw==', 0),
(26, 'fablico', '3403783946', '$2y$10$0ScgZKL10eYlZxRJI8a8tOkhvTP2Kb4uE4zOZDhH51cLooGXs2kBS', 0, 'ZmFiaW8=', 0),
(27, 'NotKing27', '3401754692', '$2y$10$tk8OBQDnZWDh/gs2mCq0/OSppE.GI/N12e7pDwpIAtV/.oNce6y0u', 0, 'cGFwYWdheW8=', 0),
(28, 'Fabio', '3472742174', '$2y$10$4QzPuutWE4ByCVPw/d5ApeCU45CCVelZwWunRvx3wX/8eLk1Ry0OC', 0, 'U3VwZXJmbHk=', 0),
(29, 'Manuel De Toffani', '3285799831', '$2y$10$5wTw7U4G77sw6qyEDHb4IuZBJLqQVHV/HEz/l9HeukjWrlz6kUO8G', 0, 'Q2lzdGVybmFsaXRlMDU=', 0),
(30, 'Casttel06', '3298507759', '$2y$10$aCRsiYwA39oE7qrHmrYjiuaKjcGwIMggCsZrjj/A1145gv1O571Y.', 0, 'RXVyb3BlaTI0IQ==', 0),
(31, 'Michele', '3396381615', '$2y$10$KeeZd5RXC6RYvFbqav94zeJetk.b1D7e6Tc0gbFX4jDlFcR2Pf8VO', 0, 'YnVidTA2MTE4MQ==', 0),
(32, 'Aldibaccon', '3333448834', '$2y$10$QwB4j3HWrwq7xbd/llyJ7.bk5iL0X0/fpJ0JYkcq04CeP3spNUtSC', 0, 'RGFsYmltMDM=', 0),
(33, 'ilplebeo', '3713096655', '$2y$10$kRlHV7xy99N7EKpNkYxXVeoGgfnLQDamWgHT6MTTohhmu7k8/i9Ku', 0, 'Q1JJU1RJQU5PNw==', 0),
(34, 'Juvemerda', '3492351600', '$2y$10$1P4uuYJj5tTlu0TslqAUCe0RyDoGadztzmOAq600yFH7zbQBlqYFm', 0, 'YWlheDE5Nzc=', 0),
(35, 'Ciucchino', '3477688941', '$2y$10$EOZi77gjtN4FNinuqYNiEOZpnJa82tQEYCryBrQek2REFED8SfkpG', 0, 'QWxpY2VncmVlbjFA', 0),
(36, 'Dega FedererðŸ˜', '3407797390', '$2y$10$aDcM19Dy.N3Tu1qyFZRGU.cSC2wX0Pf6iwa4SvaM61ER4OqULxUyC', 0, 'RXVyb3BlaTIwMjQ=', 0),
(37, 'ItzPelz', '3478236723', '$2y$10$rdLXUE1jwVjW1QCXOACTx.5Vo04RO3/UnWJjYdVw5zeL24qjxYfRK', 0, 'RmlsaWdpdWxpMzEyNg==', 0),
(38, 'Raffy', '3332427506', '$2y$10$GLj44s/kiViYWHVRBh8/KebwQUitxy07IFnlggw.jKIM80YptmXXi', 0, 'cmFmZnk=', 0),
(39, 'tik tak', '3926103608', '$2y$10$UDts8Ae4uPj8VSgMadHcIO8Cv1WA2OfgLNvpmYD8GHUuh.JQB5wF2', 0, 'bmFwb2xpMw==', 0),
(40, 'Marco Reus', '3663132558', '$2y$10$5Bj0DVMFA4jBbiHhcQEGP.QENNqGaaP.0rOQHpB3qcCqDQ84YVz1G', 0, 'RXVybzIwMjQh', 0),
(41, 'Trinkwasser', '3487360291', '$2y$10$u1.xCcBv/mxNsA/YVgB1wu9f.fwan75To1brHDFjN3krbzZ96zv3G', 0, 'czQ0YzEyNzM=', 0),
(42, 'Ettore Dal Bianco', '3466228330', '$2y$10$CaRdtTZz8QhGT/1C1U0fE.UkpIYZVggVV5xQ0K1r2l.SRC9YwLC32', 0, 'dGlhbW90YW50bzE=', 0),
(43, 'Symosimo', '3936729244', '$2y$10$CQkTPq0.DrAGYV4zpaER4OpuDAxcToXQoVA.Jfs22NFdTZkEuNrB6', 0, 'Wm9jY29sYTcx', 0),
(44, 'Tommy16', '3207235173', '$2y$10$9ILrciFP.LTqLV8Ku/7.mu/dYcgRxlKkoZkLugSK54lpoixypXs9C', 0, 'MTUxMDE1', 0),
(45, 'Nene', '3711623905', '$2y$10$zU4RRKTEitjwvNPRQqH45.yqdo1P/GNAe5VLQjlbY/ajfWTC0epve', 0, 'RmF0dG9pbG1pc2ZhdHRvOA==', 0),
(46, 'Cristian Kroos', '3205316195', '$2y$10$UWhhhmKpEZOvHmjEwTZpCuiogWf39NtBwcT3Gh8waOynY482gZqQ2', 0, 'Zm9yemFpbnRlcjAz', 0),
(47, 'The Compos', '3286821537', '$2y$10$alF7WypxphJweh9U9SIYKutTGqo.BeMhFYIQI61RdfbEIHFC54Dj.', 0, 'dmluY2Vyw7Jpbw==', 0),
(48, 'lopez88', '3403941484', '$2y$10$UTCm7yIYaJ3GYopPjAYYMe6U7xdFWCI.g3y/d6n8JwK6.pMxxyOWS', 0, 'ZmFiaW8=', 0),
(49, 'Fabio.DT.', 'fabioredo@gmail.com', '$2y$10$mzbjvM46sWHRSEweD5O4MOeI1xp8Fcwh6MHRkI.UxRlpqiinYqgey', 0, 'U3VwZXJmbHk=', 0),
(50, 'checco', '345 228 0964', '$2y$10$TwP5P4eQU8Rvuxo7g8LUlu0f7Xh1u763ov2XrHYmiXnQ8lca6f.DW', 0, 'Z2lvZnJhNjY=', 0),
(51, 'ely', '3335313837', '$2y$10$NXn12E5KRgC1dkqY932mj.4AVLGJPNuWn.FvLg0OaBL779YKa46q.', 0, 'ZWx5ZWx5', 0),
(54, 'Kikka', '3387576598', '$2y$10$L5eSoxhFYmznwwpsn563xeRZnxRJrM7AyfxWbn1pJKjpaqO8N27F2', 0, 'c2Vzc29kdXJv', 0);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `capo_azz_bet`
--
ALTER TABLE `capo_azz_bet`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `capo_euro_bet`
--
ALTER TABLE `capo_euro_bet`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `conf`
--
ALTER TABLE `conf`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `fasi`
--
ALTER TABLE `fasi`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `gironi`
--
ALTER TABLE `gironi`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `gironi_bet`
--
ALTER TABLE `gironi_bet`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `goal_veloce`
--
ALTER TABLE `goal_veloce`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `goal_veloce_bet`
--
ALTER TABLE `goal_veloce_bet`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `matches_bet`
--
ALTER TABLE `matches_bet`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `matches_fin`
--
ALTER TABLE `matches_fin`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `matches_fin_bet`
--
ALTER TABLE `matches_fin_bet`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `team_rivelaz`
--
ALTER TABLE `team_rivelaz`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `team_rivelaz_bet`
--
ALTER TABLE `team_rivelaz_bet`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `capo_azz_bet`
--
ALTER TABLE `capo_azz_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT per la tabella `capo_euro_bet`
--
ALTER TABLE `capo_euro_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT per la tabella `conf`
--
ALTER TABLE `conf`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `fasi`
--
ALTER TABLE `fasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `gironi`
--
ALTER TABLE `gironi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `gironi_bet`
--
ALTER TABLE `gironi_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT per la tabella `goal_veloce`
--
ALTER TABLE `goal_veloce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `goal_veloce_bet`
--
ALTER TABLE `goal_veloce_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT per la tabella `matches_bet`
--
ALTER TABLE `matches_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=587;

--
-- AUTO_INCREMENT per la tabella `matches_fin`
--
ALTER TABLE `matches_fin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT per la tabella `matches_fin_bet`
--
ALTER TABLE `matches_fin_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT per la tabella `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT per la tabella `team_rivelaz`
--
ALTER TABLE `team_rivelaz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `team_rivelaz_bet`
--
ALTER TABLE `team_rivelaz_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
