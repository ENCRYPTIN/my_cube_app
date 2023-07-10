import 'package:flutter/material.dart';
import 'package:my_cube/home/collapsing_appbar.dart';
import 'package:my_cube/home/Social/FeedScreen.dart';
import 'package:my_cube/home/Social/socialhome.dart';
import 'package:my_cube/home/add_post_screen.dart';
import 'package:my_cube/home/profile.dart';
import 'package:my_cube/home/rivetest.dart';

List<Widget> homeScreenItems = [
  const RiveTest(),
  const SocialHome(),
  const AddPostScreen(),
  const FeedScreen(),
  const Profile(),
];