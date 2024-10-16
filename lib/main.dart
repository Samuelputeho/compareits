import 'package:firebase_auth_youtube/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase and catch any errors
    await Firebase.initializeApp();
    Bloc.observer = SimpleBlocObserver();
    runApp(MyApp(FirebaseUserRepo()));
  } catch (e) {
    // Handle initialization error
    print('Error during Firebase initialization: $e');
  }
}
