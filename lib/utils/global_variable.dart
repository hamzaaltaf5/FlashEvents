

import 'package:firebase_auth/firebase_auth.dart';
import '../screens/activity_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

import '../screens/feed_screen.dart';
import 'package:flutter/material.dart';
import '../screens/add_post_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  ActivityScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

