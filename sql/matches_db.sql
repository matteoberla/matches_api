-- DUMP STRUTTURA + DATI DB [2026-05-14]
-- no bet, solo partite, gironi, team e 2 utenti di prova

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Mag 14, 2026 alle 11:12
-- Versione del server: 10.4.28-MariaDB
-- Versione PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `matches_db`
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
(1, 'data scadenza compilazione', '2026-06-10 20:00:00', NULL),
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
(2, 'Sedicesimi'),
(3, 'Ottavi'),
(4, 'Quarti'),
(5, 'Semifinali'),
(6, 'Finalina'),
(7, 'Finale');

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
(1, 'Girone A', 1, 2, 3, 4, NULL, NULL, NULL, NULL),
(2, 'Girone B', 5, 6, 7, 8, NULL, NULL, NULL, NULL),
(3, 'Girone C', 9, 10, 11, 12, NULL, NULL, NULL, NULL),
(4, 'Girone D', 13, 14, 15, 16, NULL, NULL, NULL, NULL),
(5, 'Girone E', 17, 18, 19, 20, NULL, NULL, NULL, NULL),
(6, 'Girone F', 21, 22, 23, 24, NULL, NULL, NULL, NULL),
(7, 'Girone G', 25, 26, 27, 28, NULL, NULL, NULL, NULL),
(8, 'Girone H', 29, 30, 31, 32, NULL, NULL, NULL, NULL),
(9, 'Girone I', 33, 34, 35, 36, NULL, NULL, NULL, NULL),
(10, 'Girone J', 37, 38, 39, 40, NULL, NULL, NULL, NULL),
(11, 'Girone K', 41, 42, 43, 44, NULL, NULL, NULL, NULL),
(12, 'Girone L', 45, 46, 47, 48, NULL, NULL, NULL, NULL);

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
(44, '2026-06-11 21:00:00', 1, 2, 1, NULL, NULL, NULL),
(45, '2026-06-12 04:00:00', 3, 4, 1, NULL, NULL, NULL),
(46, '2026-06-18 18:00:00', 4, 2, 1, NULL, NULL, NULL),
(47, '2026-06-19 03:00:00', 1, 3, 1, NULL, NULL, NULL),
(48, '2026-06-25 03:00:00', 2, 3, 1, NULL, NULL, NULL),
(49, '2026-06-25 03:00:00', 4, 1, 1, NULL, NULL, NULL),
(50, '2026-06-12 21:00:00', 5, 8, 1, NULL, NULL, NULL),
(51, '2026-06-13 21:00:00', 7, 6, 1, NULL, NULL, NULL),
(52, '2026-06-18 21:00:00', 7, 8, 1, NULL, NULL, NULL),
(53, '2026-06-20 00:00:00', 5, 6, 1, NULL, NULL, NULL),
(54, '2026-06-24 21:00:00', 7, 5, 1, NULL, NULL, NULL),
(55, '2026-06-24 21:00:00', 8, 6, 1, NULL, NULL, NULL),
(56, '2026-06-15 00:00:00', 9, 10, 1, NULL, NULL, NULL),
(57, '2026-06-14 03:00:00', 11, 12, 1, NULL, NULL, NULL),
(58, '2026-06-21 00:00:00', 12, 10, 1, NULL, NULL, NULL),
(59, '2026-06-20 03:00:00', 9, 11, 1, NULL, NULL, NULL),
(60, '2026-06-26 00:00:00', 10, 11, 1, NULL, NULL, NULL),
(61, '2026-06-26 00:00:00', 12, 9, 1, NULL, NULL, NULL),
(62, '2026-06-13 03:00:00', 13, 14, 1, NULL, NULL, NULL),
(63, '2026-06-13 06:00:00', 15, 16, 1, NULL, NULL, NULL),
(64, '2026-06-19 06:00:00', 16, 14, 1, NULL, NULL, NULL),
(65, '2026-06-19 21:00:00', 13, 15, 1, NULL, NULL, NULL),
(66, '2026-06-26 04:00:00', 16, 13, 1, NULL, NULL, NULL),
(67, '2026-06-26 04:00:00', 14, 15, 1, NULL, NULL, NULL),
(68, '2026-06-14 19:00:00', 17, 18, 1, NULL, NULL, NULL),
(69, '2026-06-14 22:00:00', 19, 20, 1, NULL, NULL, NULL),
(70, '2026-06-20 22:00:00', 17, 19, 1, NULL, NULL, NULL),
(71, '2026-06-21 02:00:00', 20, 18, 1, NULL, NULL, NULL),
(72, '2026-06-25 22:00:00', 18, 19, 1, NULL, NULL, NULL),
(73, '2026-06-25 22:00:00', 20, 17, 1, NULL, NULL, NULL),
(74, '2026-06-14 22:00:00', 21, 22, 1, NULL, NULL, NULL),
(75, '2026-06-15 04:00:00', 23, 24, 1, NULL, NULL, NULL),
(76, '2026-06-20 06:00:00', 24, 22, 1, NULL, NULL, NULL),
(77, '2026-06-20 19:00:00', 21, 23, 1, NULL, NULL, NULL),
(78, '2026-06-26 01:00:00', 24, 21, 1, NULL, NULL, NULL),
(79, '2026-06-26 01:00:00', 22, 23, 1, NULL, NULL, NULL),
(80, '2026-06-15 21:00:00', 25, 26, 1, NULL, NULL, NULL),
(81, '2026-06-16 03:00:00', 27, 28, 1, NULL, NULL, NULL),
(82, '2026-06-21 21:00:00', 25, 27, 1, NULL, NULL, NULL),
(83, '2026-06-22 03:00:00', 28, 26, 1, NULL, NULL, NULL),
(84, '2026-06-27 05:00:00', 28, 25, 1, NULL, NULL, NULL),
(85, '2026-06-27 05:00:00', 26, 27, 1, NULL, NULL, NULL),
(86, '2026-06-15 18:00:00', 29, 30, 1, NULL, NULL, NULL),
(87, '2026-06-17 00:00:00', 31, 32, 1, NULL, NULL, NULL),
(88, '2026-06-21 18:00:00', 29, 31, 1, NULL, NULL, NULL),
(89, '2026-06-23 00:00:00', 32, 30, 1, NULL, NULL, NULL),
(90, '2026-06-27 02:00:00', 30, 31, 1, NULL, NULL, NULL),
(91, '2026-06-27 02:00:00', 32, 29, 1, NULL, NULL, NULL),
(92, '2026-06-16 21:00:00', 33, 34, 1, NULL, NULL, NULL),
(93, '2026-06-18 00:00:00', 35, 36, 1, NULL, NULL, NULL),
(94, '2026-06-22 23:00:00', 33, 35, 1, NULL, NULL, NULL),
(95, '2026-06-23 02:00:00', 36, 34, 1, NULL, NULL, NULL),
(96, '2026-06-26 21:00:00', 36, 33, 1, NULL, NULL, NULL),
(97, '2026-06-26 21:00:00', 34, 35, 1, NULL, NULL, NULL),
(98, '2026-06-16 06:00:00', 39, 40, 1, NULL, NULL, NULL),
(99, '2026-06-17 03:00:00', 37, 38, 1, NULL, NULL, NULL),
(100, '2026-06-22 19:00:00', 37, 39, 1, NULL, NULL, NULL),
(101, '2026-06-23 05:00:00', 40, 38, 1, NULL, NULL, NULL),
(102, '2026-06-28 04:00:00', 38, 39, 1, NULL, NULL, NULL),
(103, '2026-06-28 04:00:00', 40, 37, 1, NULL, NULL, NULL),
(104, '2026-06-17 19:00:00', 41, 42, 1, NULL, NULL, NULL),
(105, '2026-06-18 04:00:00', 43, 44, 1, NULL, NULL, NULL),
(106, '2026-06-23 19:00:00', 41, 43, 1, NULL, NULL, NULL),
(107, '2026-06-24 04:00:00', 44, 42, 1, NULL, NULL, NULL),
(108, '2026-06-28 01:30:00', 44, 41, 1, NULL, NULL, NULL),
(109, '2026-06-28 01:30:00', 42, 43, 1, NULL, NULL, NULL),
(110, '2026-06-17 22:00:00', 45, 46, 1, NULL, NULL, NULL),
(111, '2026-06-18 01:00:00', 47, 48, 1, NULL, NULL, NULL),
(112, '2026-06-23 22:00:00', 45, 47, 1, NULL, NULL, NULL),
(113, '2026-06-24 01:00:00', 48, 46, 1, NULL, NULL, NULL),
(114, '2026-06-27 23:00:00', 48, 45, 1, NULL, NULL, NULL),
(115, '2026-06-27 23:00:00', 46, 47, 1, NULL, NULL, NULL);

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
(21, '2026-06-28 21:00:00', NULL, NULL, 73, 2, NULL, NULL, NULL, NULL, '2A', '2B'),
(22, '2026-06-29 22:30:00', NULL, NULL, 74, 2, NULL, NULL, NULL, NULL, '1E', '3A/B/C/D/F'),
(23, '2026-06-30 03:00:00', NULL, NULL, 75, 2, NULL, NULL, NULL, NULL, '1F', '2C'),
(24, '2026-06-29 19:00:00', NULL, NULL, 76, 2, NULL, NULL, NULL, NULL, '1C', '2F'),
(25, '2026-06-30 23:00:00', NULL, NULL, 77, 2, NULL, NULL, NULL, NULL, '1I', '3C/D/F/G/H'),
(26, '2026-06-30 19:00:00', NULL, NULL, 78, 2, NULL, NULL, NULL, NULL, '2E', '2I'),
(27, '2026-07-01 03:00:00', NULL, NULL, 79, 2, NULL, NULL, NULL, NULL, '1A', '3C/E/F/H/I'),
(28, '2026-07-01 18:00:00', NULL, NULL, 80, 2, NULL, NULL, NULL, NULL, '1L', '3E/H/I/J/K'),
(29, '2026-07-02 02:00:00', NULL, NULL, 81, 2, NULL, NULL, NULL, NULL, '1D', '3B/E/F/I/J'),
(30, '2026-07-01 22:00:00', NULL, NULL, 82, 2, NULL, NULL, NULL, NULL, '1G', '3A/E/H/I/J'),
(31, '2026-07-03 01:00:00', NULL, NULL, 83, 2, NULL, NULL, NULL, NULL, '2K', '2L'),
(32, '2026-07-02 21:00:00', NULL, NULL, 84, 2, NULL, NULL, NULL, NULL, '1H', '2J'),
(33, '2026-07-03 05:00:00', NULL, NULL, 85, 2, NULL, NULL, NULL, NULL, '1B', '3E/F/G/I/J'),
(34, '2026-07-04 00:00:00', NULL, NULL, 86, 2, NULL, NULL, NULL, NULL, '1J', '2H'),
(35, '2026-07-04 03:30:00', NULL, NULL, 87, 2, NULL, NULL, NULL, NULL, '1K', '3D/E/I/J/L'),
(36, '2026-07-03 20:00:00', NULL, NULL, 88, 2, NULL, NULL, NULL, NULL, '2D', '2G'),
(37, '2026-07-04 23:00:00', NULL, NULL, 89, 3, NULL, NULL, NULL, NULL, 'W74', 'W77'),
(38, '2026-07-04 19:00:00', NULL, NULL, 90, 3, NULL, NULL, NULL, NULL, 'W73', 'W75'),
(39, '2026-07-05 22:00:00', NULL, NULL, 91, 3, NULL, NULL, NULL, NULL, 'W76', 'W78'),
(40, '2026-07-06 02:00:00', NULL, NULL, 92, 3, NULL, NULL, NULL, NULL, 'W79', 'W80'),
(41, '2026-07-06 21:00:00', NULL, NULL, 93, 3, NULL, NULL, NULL, NULL, 'W83', 'W84'),
(42, '2026-07-07 02:00:00', NULL, NULL, 94, 3, NULL, NULL, NULL, NULL, 'W81', 'W82'),
(43, '2026-07-07 18:00:00', NULL, NULL, 95, 3, NULL, NULL, NULL, NULL, 'W86', 'W88'),
(44, '2026-07-07 22:00:00', NULL, NULL, 96, 3, NULL, NULL, NULL, NULL, 'W85', 'W87'),
(45, '2026-07-09 22:00:00', NULL, NULL, 97, 4, NULL, NULL, NULL, NULL, 'W89', 'W90'),
(46, '2026-07-10 21:00:00', NULL, NULL, 98, 4, NULL, NULL, NULL, NULL, 'W93', 'W94'),
(47, '2026-07-11 23:00:00', NULL, NULL, 99, 4, NULL, NULL, NULL, NULL, 'W91', 'W92'),
(48, '2026-07-12 03:00:00', NULL, NULL, 100, 4, NULL, NULL, NULL, NULL, 'W95', 'W96'),
(49, '2026-07-14 21:00:00', NULL, NULL, 101, 5, NULL, NULL, NULL, NULL, 'W97', 'W98'),
(50, '2026-07-15 21:00:00', NULL, NULL, 102, 5, NULL, NULL, NULL, NULL, 'W99', 'W100'),
(51, '2026-07-18 23:00:00', NULL, NULL, 103, 6, NULL, NULL, NULL, NULL, 'L101', 'L102'),
(52, '2026-07-19 21:00:00', NULL, NULL, 104, 7, NULL, NULL, NULL, NULL, 'W101', 'W102');

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
(1, 'Messico', 'MX', 'A', 'MEX'),
(2, 'Sudafrica', 'ZA', 'A', 'RSA'),
(3, 'Corea del Sud', 'KR', 'A', 'KOR'),
(4, 'Repubblica Ceca', 'CZ', 'A', 'CZE'),
(5, 'Canada', 'CA', 'B', 'CAN'),
(6, 'Qatar', 'QA', 'B', 'QAT'),
(7, 'Svizzera', 'CH', 'B', 'SUI'),
(8, 'Bosnia', 'BA', 'B', 'BIH'),
(9, 'Brasile', 'BR', 'C', 'BRA'),
(10, 'Marocco', 'MA', 'C', 'MAR'),
(11, 'Haiti', 'HT', 'C', 'HAI'),
(12, 'Scozia', 'GB-SCT', 'C', 'SCO'),
(13, 'Usa', 'US', 'D', 'USA'),
(14, 'Paraguay', 'PY', 'D', 'PAR'),
(15, 'Australia', 'AU', 'D', 'AUS'),
(16, 'Turchia', 'TR', 'D', 'TUR'),
(17, 'Germania', 'DE', 'E', 'GER'),
(18, 'Curacao', 'CW', 'E', 'CUW'),
(19, 'Costa d\'Avorio', 'CI', 'E', 'CIV'),
(20, 'Ecuador', 'EC', 'E', 'ECU'),
(21, 'Olanda', 'NL', 'F', 'NED'),
(22, 'Giappone', 'JP', 'F', 'JPN'),
(23, 'Svezia', 'SE', 'F', 'SWE'),
(24, 'Tunisia', 'TN', 'F', 'TUN'),
(25, 'Belgio', 'BE', 'G', 'BEL'),
(26, 'Egitto', 'EG', 'G', 'EGY'),
(27, 'Iran', 'IR', 'G', 'IRN'),
(28, 'Nuova Zelanda', 'NZ', 'G', 'NZL'),
(29, 'Spagna', 'ES', 'H', 'ESP'),
(30, 'Capo Verde', 'CV', 'H', 'CPV'),
(31, 'Arabia Saudita', 'SA', 'H', 'KSA'),
(32, 'Uruguay', 'UY', 'H', 'URU'),
(33, 'Francia', 'FR', 'I', 'FRA'),
(34, 'Senegal', 'SN', 'I', 'SEN'),
(35, 'Iraq', 'IQ', 'I', 'IRQ'),
(36, 'Norvegia', 'NO', 'I', 'NOR'),
(37, 'Argentina', 'AR', 'J', 'ARG'),
(38, 'Algeria', 'DZ', 'J', 'ALG'),
(39, 'Austria', 'AT', 'J', 'AUT'),
(40, 'Giordania', 'JO', 'J', 'JOR'),
(41, 'Portogallo', 'PT', 'K', 'POR'),
(42, 'RD Congo', 'CD', 'K', 'COD'),
(43, 'Uzbekistan', 'UZ', 'K', 'UZB'),
(44, 'Colombia', 'CO', 'K', 'COL'),
(45, 'Inghilterra', 'GB-ENG', 'L', 'ENG'),
(46, 'Croazia', 'HR', 'L', 'CRO'),
(47, 'Ghana', 'GH', 'L', 'GHA'),
(48, 'Panama', 'PA', 'L', 'PAN');

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
(1, 'matteo berlato', 'matteoberla02@gmail.com', '$2y$10$YYh0z4rnr3U0N3F0qaNUTuuSlFWV/2hTgIzLYAvgbMXI8IiU0ST3m', 1, 'VGxtc3JuNjkw', 0),
(20, 'Mannero', '3343175918', '$2y$10$YYh0z4rnr3U0N3F0qaNUTuuSlFWV/2hTgIzLYAvgbMXI8IiU0ST3m', 0, 'VGxtc3JuNjkw', 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT per la tabella `gironi`
--
ALTER TABLE `gironi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT per la tabella `matches_bet`
--
ALTER TABLE `matches_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=588;

--
-- AUTO_INCREMENT per la tabella `matches_fin`
--
ALTER TABLE `matches_fin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT per la tabella `matches_fin_bet`
--
ALTER TABLE `matches_fin_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT per la tabella `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

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
