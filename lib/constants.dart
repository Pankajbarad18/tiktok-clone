import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';

const Color bgColor = Colors.black;
var buttonColor = Colors.red[400];
const Color borderColor = Colors.grey;

//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

var authController = AuthController.instance;

//Pages
var pages = [
  const Center(child: Text('HomePage')),
  const Center(child: Text('SearchPage')),
  const Center(child: Text('AddPage')),
  const Center(child: Text('MessagePage')),
  const Center(child: Text('ProfilePage')),
];
