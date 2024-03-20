import 'package:firebase_auth/firebase_auth.dart'  show User;
import 'package:flutter/material.dart';

@immutable //nie beda sie zmieniac rzeczy w klasie
class AuthUser{
  final bool isEmailVerified;
  const AuthUser( this.isEmailVerified);

  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}