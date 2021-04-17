-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2021 at 02:28 PM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sas`
--

-- --------------------------------------------------------

--
-- Table structure for table `admininfo`
--

CREATE TABLE `admininfo` (
  `id` int(2) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admininfo`
--

INSERT INTO `admininfo` (`id`, `username`, `password`) VALUES
(1, 'admin', '$2y$10$ZomME1WzvR/M7BslKgI2SeY/nmy7HTAeAIPJAoqc8KSZ5/GiPBjhu');

-- --------------------------------------------------------

--
-- Table structure for table `classinfo`
--

CREATE TABLE `classinfo` (
  `classid` int(100) NOT NULL,
  `courseid` varchar(50) NOT NULL,
  `year` varchar(10) NOT NULL,
  `division` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classinfo`
--

INSERT INTO `classinfo` (`classid`, `courseid`, `year`, `division`) VALUES
(1, '1', 'fy', 'a'),
(2, '2', 'fy', 'a');

-- --------------------------------------------------------

--
-- Table structure for table `courseinfo`
--

CREATE TABLE `courseinfo` (
  `courseid` tinyint(4) NOT NULL,
  `coursename` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courseinfo`
--

INSERT INTO `courseinfo` (`courseid`, `coursename`) VALUES
(2, 'bca'),
(1, 'csit');

-- --------------------------------------------------------

--
-- Table structure for table `fybca-a`
--

CREATE TABLE `fybca-a` (
  `attid` int(5) NOT NULL,
  `date` date DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `subid` int(3) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fycsit-a`
--

CREATE TABLE `fycsit-a` (
  `attid` int(5) NOT NULL,
  `date` date DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `subid` int(3) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `r727` tinyint(1) NOT NULL DEFAULT 0,
  `c727` text CHARACTER SET latin1 DEFAULT NULL,
  `r721` tinyint(1) NOT NULL DEFAULT 0,
  `c721` text DEFAULT NULL,
  `r750` tinyint(1) NOT NULL DEFAULT 0,
  `c750` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fycsit-a`
--

INSERT INTO `fycsit-a` (`attid`, `date`, `time`, `subid`, `status`, `r727`, `c727`, `r721`, `c721`, `r750`, `c750`) VALUES
(2, '2021-02-23', '2021-02-22 22:02:37', 1, 1, 1, NULL, 0, NULL, 0, NULL),
(4, '2021-03-17', '2021-03-16 22:59:35', 2, 1, 0, NULL, 0, NULL, 0, NULL),
(5, '2021-03-18', '2021-03-18 05:20:36', 1, 1, 1, NULL, 0, NULL, 0, NULL),
(6, '2021-03-19', '2021-03-18 20:30:25', 1, 1, 0, NULL, 0, NULL, 0, NULL),
(9, '2021-03-22', '2021-03-21 19:47:12', 1, 1, 0, NULL, 0, NULL, 0, NULL),
(10, '2021-03-22', '2021-03-21 19:48:31', 1, 1, 1, NULL, 0, NULL, 0, NULL),
(11, '2021-03-22', '2021-03-21 22:15:00', 1, 1, 1, NULL, 1, 'SICK', 1, 'Sick');

-- --------------------------------------------------------

--
-- Table structure for table `logincontrol`
--

CREATE TABLE `logincontrol` (
  `id` int(11) NOT NULL,
  `unixtime` int(15) NOT NULL,
  `username` text NOT NULL,
  `ip` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logincontrol`
--

INSERT INTO `logincontrol` (`id`, `unixtime`, `username`, `ip`) VALUES
(90, 1615978426, 'asdfasdfas', '::1'),
(91, 1615978436, 'adfadf', '::1'),
(93, 1615978585, 'fadfasdfasd', '::1'),
(101, 1616045245, 'bijay.regmi', '::1');

-- --------------------------------------------------------

--
-- Table structure for table `studentinfo`
--

CREATE TABLE `studentinfo` (
  `id` int(11) NOT NULL,
  `rollno` smallint(6) NOT NULL,
  `name` tinytext NOT NULL,
  `username` varchar(200) DEFAULT NULL,
  `password` varchar(200) NOT NULL,
  `email` text NOT NULL,
  `classid` smallint(6) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `studentinfo`
--

INSERT INTO `studentinfo` (`id`, `rollno`, `name`, `username`, `password`, `email`, `classid`, `status`) VALUES
(1, 727, 'aashish tamang', 'aashish.tamang', '$2y$10$YlrU3f0TfHxp5A1i9CDfI.PSACmlvph5vviJwiEhcuV/vXgwZDbhS', '', 1, 0),
(2, 721, 'ramesh tamang', 'ramesh.tamang', '$2y$10$8ypAgWZEmC.ZjKf6AqHoGuYeySA1C.kESqOp5qlsS9rCB9DFJhTwK', '', 1, 0),
(3, 750, 'aakash bhandari', 'aakash.bhandari', '$2y$10$nDy.WxpRNmYaIJz0IuQO6OcBZ2VNzVGlOLfvJ2rEtDYFXLGkCgG9y', '', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `subjectinfo`
--

CREATE TABLE `subjectinfo` (
  `subjectid` int(100) NOT NULL,
  `subname` varchar(100) NOT NULL,
  `classid` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subjectinfo`
--

INSERT INTO `subjectinfo` (`subjectid`, `subname`, `classid`) VALUES
(1, 'e-commerce', 1),
(2, 'software engineering', 1);

-- --------------------------------------------------------

--
-- Table structure for table `teacherinfo`
--

CREATE TABLE `teacherinfo` (
  `tid` int(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `rights` char(2) NOT NULL DEFAULT 'T',
  `sub1` int(100) DEFAULT NULL,
  `sub2` int(100) DEFAULT NULL,
  `sub3` int(100) DEFAULT NULL,
  `sub4` int(100) DEFAULT NULL,
  `sub5` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacherinfo`
--

INSERT INTO `teacherinfo` (`tid`, `name`, `username`, `password`, `rights`, `sub1`, `sub2`, `sub3`, `sub4`, `sub5`) VALUES
(1, 'rohan tamang', 'rohan.tamang', '$2y$10$TuUsvLQjXaCu0kUIx4OXL.SvJiHRx1V3sQob/b9k4f9kCny.Hf1eG', 't', 1, 1, 1, 1, 1),
(2, 'bijay babu regmi', 'bijya.regmi', '$2y$10$pn11Noy5Ht/LuoLKZ49zRO5gUOzRFRSz8krA5EjK5orfVvF71MdCe', 't', 2, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admininfo`
--
ALTER TABLE `admininfo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `classinfo`
--
ALTER TABLE `classinfo`
  ADD PRIMARY KEY (`classid`),
  ADD UNIQUE KEY `courseid` (`courseid`,`year`,`division`);

--
-- Indexes for table `courseinfo`
--
ALTER TABLE `courseinfo`
  ADD PRIMARY KEY (`courseid`),
  ADD UNIQUE KEY `coursename` (`coursename`);

--
-- Indexes for table `fybca-a`
--
ALTER TABLE `fybca-a`
  ADD PRIMARY KEY (`attid`);

--
-- Indexes for table `fycsit-a`
--
ALTER TABLE `fycsit-a`
  ADD PRIMARY KEY (`attid`);

--
-- Indexes for table `logincontrol`
--
ALTER TABLE `logincontrol`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `studentinfo`
--
ALTER TABLE `studentinfo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `username` (`username`(64));

--
-- Indexes for table `subjectinfo`
--
ALTER TABLE `subjectinfo`
  ADD PRIMARY KEY (`subjectid`);

--
-- Indexes for table `teacherinfo`
--
ALTER TABLE `teacherinfo`
  ADD PRIMARY KEY (`tid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admininfo`
--
ALTER TABLE `admininfo`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `classinfo`
--
ALTER TABLE `classinfo`
  MODIFY `classid` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `courseinfo`
--
ALTER TABLE `courseinfo`
  MODIFY `courseid` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `fybca-a`
--
ALTER TABLE `fybca-a`
  MODIFY `attid` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fycsit-a`
--
ALTER TABLE `fycsit-a`
  MODIFY `attid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `logincontrol`
--
ALTER TABLE `logincontrol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `subjectinfo`
--
ALTER TABLE `subjectinfo`
  MODIFY `subjectid` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `teacherinfo`
--
ALTER TABLE `teacherinfo`
  MODIFY `tid` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
