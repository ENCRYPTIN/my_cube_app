import 'package:flutter/material.dart';
import 'package:my_cube/home/Social/FeedScreen.dart';
import 'package:my_cube/home/Social/search_screen.dart';
import 'package:my_cube/home/Social/socialhome.dart';
import 'package:my_cube/home/add_post_screen.dart';
import 'package:my_cube/home/mainhomepage.dart';
import 'package:my_cube/home/profile.dart';

List<Widget> homeScreenItems = [
  const MainHomePage(),
  const SocialHome(),
  const AddPostScreen(),
  const FeedScreen(),
  const Profile(),
];