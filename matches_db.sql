-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Feb 27, 2024 alle 17:25
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

--
-- Dump dei dati per la tabella `capo_azz_bet`
--

INSERT INTO `capo_azz_bet` (`id`, `user_id`, `bet_num`, `value`, `is_valid`, `points`) VALUES
(6, 1, 1, 'a', 1, 1),
(7, 1, 2, 'a', 0, 3);

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
(1, 1, 1, 'a', 0, 1),
(3, 1, 2, 'b', 0, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `conf`
--

CREATE TABLE `conf` (
  `id` int(11) NOT NULL,
  `des` text NOT NULL,
  `datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `conf`
--

INSERT INTO `conf` (`id`, `des`, `datetime`) VALUES
(1, 'data scadenza compilazione', '2024-06-01 00:00:00');

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
(7, 'Girone A', 2, 7, 8, 6, 1, 4, 3, 2),
(8, 'Girone B', 5, 3, 1, 9, NULL, NULL, NULL, NULL),
(9, 'Girone C', 10, 11, 12, 13, NULL, NULL, NULL, NULL);

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
(6, 1, 'Girone A', 1, 2, 4, 3, 5);

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
(1, 7);

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
(5, 1, 1, 2, 1);

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
(11, '2024-06-15 21:00:00', 1, 9, 1, NULL, NULL, NULL);

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
  `des_1` text NOT NULL,
  `des_2` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `matches_fin`
--

INSERT INTO `matches_fin` (`id`, `date`, `id_team_1`, `id_team_2`, `n_match`, `fase`, `goal_team_1`, `goal_team_2`, `result`, `des_1`, `des_2`) VALUES
(6, '2024-06-30 21:00:00', NULL, NULL, 39, 2, NULL, NULL, NULL, '1B', '3A/D/E/F'),
(7, '2024-06-29 21:00:00', NULL, NULL, 37, 2, NULL, NULL, NULL, '1A', '2C'),
(8, '2024-07-01 21:00:00', NULL, NULL, 41, 2, NULL, NULL, NULL, '1F', '3A/B/C'),
(9, '2024-07-01 18:00:00', NULL, NULL, 42, 2, NULL, NULL, NULL, '2D', '2E'),
(10, '2024-07-02 18:00:00', NULL, NULL, 43, 2, NULL, NULL, NULL, '1E', '3A/B/C/D'),
(11, '2024-07-02 21:00:00', NULL, NULL, 44, 2, NULL, NULL, NULL, '1D', '2F'),
(12, '2024-06-30 18:00:00', NULL, NULL, 40, 2, NULL, NULL, NULL, '1C', '3D/E/F'),
(13, '2024-06-29 18:00:00', NULL, NULL, 38, 2, NULL, NULL, NULL, '2A', '2B'),
(14, '2024-07-05 18:00:00', NULL, NULL, 45, 3, NULL, NULL, NULL, 'W39', 'W37'),
(15, '2024-07-05 21:00:00', NULL, NULL, 46, 3, NULL, NULL, NULL, 'W41', 'W42'),
(16, '2024-07-06 21:00:00', NULL, NULL, 47, 3, NULL, NULL, NULL, 'W43', 'W44'),
(17, '2024-07-06 18:00:00', NULL, NULL, 48, 3, NULL, NULL, NULL, 'W40', 'W38'),
(18, '2024-07-09 21:00:00', NULL, NULL, 49, 4, NULL, NULL, NULL, 'W45', 'W46'),
(19, '2024-07-10 21:00:00', NULL, NULL, 50, 4, NULL, NULL, NULL, 'W47', 'W48'),
(20, '2024-07-14 21:00:00', NULL, NULL, 51, 5, NULL, NULL, NULL, 'W49', 'W50');

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
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `matches_fin_bet`
--

INSERT INTO `matches_fin_bet` (`id`, `user_id`, `match_id`, `id_team_1`, `id_team_2`, `goal_team_1`, `goal_team_2`, `result`, `points`) VALUES
(7, 1, 7, 2, 7, 2, 0, '1', 1),
(8, 1, 14, 1, 2, 1, 0, '1', NULL),
(9, 1, 6, 9, 1, 2, 3, '2', NULL),
(10, 1, 13, 6, 9, 1, 1, 'X', NULL),
(11, 1, 18, 1, 8, NULL, NULL, NULL, NULL),
(12, 1, 15, 8, 5, 1, 0, '1', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `iso` text NOT NULL,
  `girone` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `teams`
--

INSERT INTO `teams` (`id`, `name`, `iso`, `girone`) VALUES
(1, 'Italia', 'IT', 'B'),
(2, 'Germania', 'DE', 'A'),
(3, 'Croazia', 'HR', 'B'),
(4, 'Francia', 'FR', 'D'),
(5, 'Spagna', 'ES', 'B'),
(6, 'Svizzera', 'CH', 'A'),
(7, 'Scozia', 'GB-SCT', 'A'),
(8, 'Ungheria', 'HU', 'A'),
(9, 'Albania', 'AL', 'B'),
(10, 'Slovenia', 'SI', 'C'),
(11, 'Danimarca', 'DK', 'C'),
(12, 'Serbia', 'RS', 'C'),
(13, 'Inghilterra', 'GB-ENG', 'C');

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
(1, 7);

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
(2, 1, 1, 9, 2);

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
  `isActive` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `admin`, `isActive`) VALUES
(1, 'matteo berlato', 'matteoberla02@gmail.com', '$2y$10$Rx3eENdoTiiTwK1Jyw.xzu/anIkPC9NJMsPSWwUpOoAE6FJAVFv8u', 1, 1),
(6, 'jana frigo', 'janafrigo06@gmail.com', '$2y$10$6wiTKZtAEcRgSpVHrQC6ee9/Apdw2SQkZ082Xae2nC4F5C0zBXLUC', 0, 0),
(9, 'test', 'test@test.com', '$2y$10$fgoZoDHCZnjzJfHldcKqcup/PN0ZtMol.4xcNHu5Y3ekcL9SXAljq', 0, 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT per la tabella `capo_euro_bet`
--
ALTER TABLE `capo_euro_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `conf`
--
ALTER TABLE `conf`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `fasi`
--
ALTER TABLE `fasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `gironi`
--
ALTER TABLE `gironi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT per la tabella `gironi_bet`
--
ALTER TABLE `gironi_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `goal_veloce`
--
ALTER TABLE `goal_veloce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `goal_veloce_bet`
--
ALTER TABLE `goal_veloce_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT per la tabella `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT per la tabella `matches_bet`
--
ALTER TABLE `matches_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT per la tabella `matches_fin`
--
ALTER TABLE `matches_fin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT per la tabella `matches_fin_bet`
--
ALTER TABLE `matches_fin_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT per la tabella `team_rivelaz`
--
ALTER TABLE `team_rivelaz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `team_rivelaz_bet`
--
ALTER TABLE `team_rivelaz_bet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
