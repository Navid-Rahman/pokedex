import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/core/app_theme.dart';
import 'package:pokedex/firebase_options.dart';
import 'package:pokedex/service/auth_service.dart';
import 'package:provider/provider.dart';

import 'env/env.dart';
import 'routes.dart';
import 'screens/splash_screen.dart';

/// The entry point of the application.
///
/// This function initializes Firebase, sets up the system UI overlay style,
/// and runs the Flutter application wrapped with a `Provider` for authentication service.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase based on the platform
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Env.firebaseApiKey,
        authDomain: Env.firebaseAuthDomain,
        projectId: Env.firebaseProjectId,
        storageBucket: Env.firebaseStorageBucket,
        messagingSenderId: Env.firebaseMessagingSenderId,
        appId: Env.firebaseAppId,
        measurementId: Env.firebaseMeasurementId,
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Set global system UI appearance
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xff1A1A1D),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Run the application with AuthService provider
  runApp(
    Provider<AuthService>(
      create: (_) => AuthService(),
      child: const MyApp(),
    ),
  );
}

/// The root widget of the application.
///
/// This widget sets up the MaterialApp with predefined routes, themes,
/// and the initial screen to be displayed.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokéDex',
      routes: routes, // Defined application routes
      theme: AppTheme.theme, // Apply global theme
      initialRoute: SplashScreen.routeName, // Set the initial screen
    );
  }
}
