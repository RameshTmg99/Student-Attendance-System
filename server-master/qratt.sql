-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2020 at 04:35 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

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
(2, '2', 'sy', 'a');

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
(1, 'computing'),
(3, 'multimedia'),
(2, 'networking');
 
-- --------------------------------------------------------

--
-- Table structure for table `fycomputing-a`
--

CREATE TABLE `fycomputing-a` (
  `attid` int(5) NOT NULL,
  `date` date DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `subid` int(3) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `r1` tinyint(1) NOT NULL DEFAULT 0,
  `c1` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fycomputing-a`
--

INSERT INTO `fycomputing-a` (`attid`, `date`, `time`, `subid`, `status`, `r1`, `c1`) VALUES
(2, '2020-05-26', '2020-05-26 02:30:40', 4, 0, 0, NULL),
(3, '2020-05-26', '2020-05-26 03:41:10', 1, 1, 0, NULL),
(4, '2020-05-26', '2020-05-26 03:46:41', 1, 1, 1, NULL),
(5, '2020-05-26', '2020-05-26 03:58:23', 2, 1, 1, NULL),
(6, '2020-05-27', '2020-05-27 02:01:23', 1, 1, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fycomputing-a-multi`
--

CREATE TABLE `fycomputing-a-multi` (
  `id` int(3) UNSIGNED NOT NULL,
  `sid` int(3) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ip` varchar(25) DEFAULT NULL,
  `user-agent` varchar(100) DEFAULT NULL,
  `uid` varchar(10) DEFAULT NULL,
  `cid` varchar(10) DEFAULT NULL,
  `imei` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(101, 1, 'siddhartha sapkota', 'siddhartha', '$2y$10$RUg.sf7Qyyh2/IGHQqiapu2UfRgMHE07/QYndpRPtE9gTlFy2SU86', '', 1, 0),
(102, 1, 'aayush subedi', 'aayush', '$2y$10$Wh0x4eLzno3aHo6KdqRKd.V9WybVXDd4I7HsI6bea8zmK11Y1lEm6', '', 2, 0);

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
(1, 'programming', 1),
(2, 'database', 1),
(3, 'ethics', 1),
(4, 'logic', 1),
(5, 'artificial intelligence', 1);

-- --------------------------------------------------------

--
-- Table structure for table `synetworking-a`
--

CREATE TABLE `synetworking-a` (
  `attid` int(5) NOT NULL,
  `date` date DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `subid` int(3) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `r1` tinyint(1) NOT NULL DEFAULT 0,
  `c1` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, 'siddhartha', 'siddhartha', '$2y$10$CNTUIJcWHdzGGO8ojR6Dzej09dRChSgBR7TnHonetJ/AKHUtLqcaK', 't', 1, 2, 3, 4, 5);

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
-- Indexes for table `fycomputing-a`
--
ALTER TABLE `fycomputing-a`
  ADD PRIMARY KEY (`attid`);

--
-- Indexes for table `fycomputing-a-multi`
--
ALTER TABLE `fycomputing-a-multi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sid` (`sid`);

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
-- Indexes for table `synetworking-a`
--
ALTER TABLE `synetworking-a`
  ADD PRIMARY KEY (`attid`);

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
  MODIFY `courseid` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fycomputing-a`
--
ALTER TABLE `fycomputing-a`
  MODIFY `attid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `fycomputing-a-multi`
--
ALTER TABLE `fycomputing-a-multi`
  MODIFY `id` int(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logincontrol`
--
ALTER TABLE `logincontrol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `subjectinfo`
--
ALTER TABLE `subjectinfo`
  MODIFY `subjectid` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `synetworking-a`
--
ALTER TABLE `synetworking-a`
  MODIFY `attid` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacherinfo`
--
ALTER TABLE `teacherinfo`
  MODIFY `tid` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
