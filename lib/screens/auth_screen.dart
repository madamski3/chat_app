import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(
    String email,
    String? username,
    String password,
    File? userImage,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    setState(() {
      _isLoading = true;
    });
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance.ref().child('user_images').child(authResult.user!.uid + '.jpg');
        ref.putFile(userImage!).whenComplete(() async {
          final url = await ref.getDownloadURL();

          FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
            'username': username,
            'email': email,
            'image_url': url,
          });
        });
      }
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (e) {
      var message = 'An error occurred. Please check your credentials';
      if (e.message != null) {
        message = e.message!;
      }
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (e) {
      var message = 'Something happened';
      if (e.toString() != '') {
        message = e.toString();
      }
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
