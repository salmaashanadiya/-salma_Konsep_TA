-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 06, 2026 at 03:50 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsalma_ta_absengaji`
--

-- --------------------------------------------------------

--
-- Table structure for table `absensi_salma`
--

CREATE TABLE `absensi_salma` (
  `id_absensi_salma` int(11) NOT NULL,
  `id_user_salma` int(11) NOT NULL,
  `tanggal_absensi_salma` date NOT NULL,
  `jam_masuk_salma` time DEFAULT NULL,
  `jam_pulang_salma` time DEFAULT NULL,
  `status_absensi_salma` enum('hadir','izin','sakit','alpha') DEFAULT 'hadir',
  `keterangan_salma` varchar(100) DEFAULT NULL,
  `created_at_salma` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gaji_salma`
--

CREATE TABLE `gaji_salma` (
  `id_gaji_salma` int(11) NOT NULL,
  `id_user_salma` int(11) NOT NULL,
  `tahun_gaji_salma` year(4) NOT NULL,
  `bulan_gaji_salma` tinyint(4) NOT NULL CHECK (`bulan_gaji_salma` between 1 and 12),
  `gaji_pokok_salma` decimal(12,2) NOT NULL,
  `bonus_salma` decimal(12,2) DEFAULT 0.00,
  `potongan_salma` decimal(12,2) DEFAULT 0.00,
  `total_gaji_salma` decimal(12,2) GENERATED ALWAYS AS (`gaji_pokok_salma` + `bonus_salma` - `potongan_salma`) STORED,
  `status_gaji_salma` enum('belum_dibayar','sudah_dibayar') DEFAULT 'belum_dibayar',
  `tanggal_pembayaran_salma` date DEFAULT NULL,
  `created_at_salma` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `izin_salma`
--

CREATE TABLE `izin_salma` (
  `id_izin_salma` int(11) NOT NULL,
  `id_user_salma` int(11) NOT NULL,
  `tanggal_mulai_salma` date NOT NULL,
  `tanggal_selesai_salma` date NOT NULL,
  `jenis_izin_salma` enum('izin','sakit','cuti') NOT NULL,
  `alasan_izin_salma` text DEFAULT NULL,
  `status_izin_salma` enum('pending','disetujui','ditolak') DEFAULT 'pending',
  `created_at_salma` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slip_gaji_salma`
--

CREATE TABLE `slip_gaji_salma` (
  `id_slip_gaji_salma` int(11) NOT NULL,
  `id_gaji_salma` int(11) NOT NULL,
  `nomor_slip_salma` varchar(50) NOT NULL,
  `tanggal_cetak_salma` date NOT NULL,
  `total_diterima_salma` decimal(12,2) NOT NULL,
  `metode_pembayaran_salma` enum('tunai','transfer') DEFAULT 'transfer',
  `catatan_salma` text DEFAULT NULL,
  `created_at_salma` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users_salma`
--

CREATE TABLE `users_salma` (
  `id_user_salma` int(11) NOT NULL,
  `username_salma` varchar(50) NOT NULL,
  `email_salma` varchar(100) NOT NULL,
  `password_salma` varchar(255) NOT NULL,
  `nama_salma` varchar(100) NOT NULL,
  `nip_salma` varchar(20) NOT NULL,
  `jabatan_salma` varchar(50) DEFAULT NULL,
  `role_salma` enum('admin','karyawan') DEFAULT 'karyawan',
  `status_user_salma` enum('aktif','nonaktif') DEFAULT 'aktif',
  `created_at_salma` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at_salma` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `absensi_salma`
--
ALTER TABLE `absensi_salma`
  ADD PRIMARY KEY (`id_absensi_salma`),
  ADD KEY `id_user_salma` (`id_user_salma`);

--
-- Indexes for table `gaji_salma`
--
ALTER TABLE `gaji_salma`
  ADD PRIMARY KEY (`id_gaji_salma`),
  ADD KEY `id_user_salma` (`id_user_salma`);

--
-- Indexes for table `izin_salma`
--
ALTER TABLE `izin_salma`
  ADD PRIMARY KEY (`id_izin_salma`),
  ADD KEY `id_user_salma` (`id_user_salma`);

--
-- Indexes for table `slip_gaji_salma`
--
ALTER TABLE `slip_gaji_salma`
  ADD PRIMARY KEY (`id_slip_gaji_salma`),
  ADD UNIQUE KEY `nomor_slip_salma` (`nomor_slip_salma`),
  ADD KEY `id_gaji_salma` (`id_gaji_salma`);

--
-- Indexes for table `users_salma`
--
ALTER TABLE `users_salma`
  ADD PRIMARY KEY (`id_user_salma`),
  ADD UNIQUE KEY `username_salma` (`username_salma`),
  ADD UNIQUE KEY `email_salma` (`email_salma`),
  ADD UNIQUE KEY `nip_salma` (`nip_salma`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `absensi_salma`
--
ALTER TABLE `absensi_salma`
  MODIFY `id_absensi_salma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gaji_salma`
--
ALTER TABLE `gaji_salma`
  MODIFY `id_gaji_salma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `izin_salma`
--
ALTER TABLE `izin_salma`
  MODIFY `id_izin_salma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slip_gaji_salma`
--
ALTER TABLE `slip_gaji_salma`
  MODIFY `id_slip_gaji_salma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users_salma`
--
ALTER TABLE `users_salma`
  MODIFY `id_user_salma` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `absensi_salma`
--
ALTER TABLE `absensi_salma`
  ADD CONSTRAINT `absensi_salma_ibfk_1` FOREIGN KEY (`id_user_salma`) REFERENCES `users_salma` (`id_user_salma`) ON DELETE CASCADE;

--
-- Constraints for table `gaji_salma`
--
ALTER TABLE `gaji_salma`
  ADD CONSTRAINT `gaji_salma_ibfk_1` FOREIGN KEY (`id_user_salma`) REFERENCES `users_salma` (`id_user_salma`) ON DELETE CASCADE;

--
-- Constraints for table `izin_salma`
--
ALTER TABLE `izin_salma`
  ADD CONSTRAINT `izin_salma_ibfk_1` FOREIGN KEY (`id_user_salma`) REFERENCES `users_salma` (`id_user_salma`) ON DELETE CASCADE;

--
-- Constraints for table `slip_gaji_salma`
--
ALTER TABLE `slip_gaji_salma`
  ADD CONSTRAINT `slip_gaji_salma_ibfk_1` FOREIGN KEY (`id_gaji_salma`) REFERENCES `gaji_salma` (`id_gaji_salma`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
