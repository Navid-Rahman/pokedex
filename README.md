# Pokédex Flutter App

A modern, cross-platform Pokédex application built with Flutter, showcasing Pokémon data with Firebase authentication and a sleek UI. Explore Pokémon by name or number, filter and sort them, and enjoy a seamless user experience powered by Flutter’s capabilities.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Technologies](#technologies)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features
- **User Authentication:**
    - Sign in/up with email and password.
    - Google Sign-In integration.
    - User data stored in Firebase Firestore.
- **Pokémon Browsing:**
    - View a grid of Pokémon with images, names, and numbers.
    - Search Pokémon by name or number.
    - Sort Pokémon by name or number using a filter modal.
- **Responsive Design:**
    - Optimized for iOS, Android, and web platforms.
    - Smooth animations and a glassmorphism-inspired UI.
- **Logging & Debugging:**
    - Integrated Talker for detailed console logging.
    - Error handling with user-friendly messages.
- **Splash Screen:**
    - Custom splash screen with a Pokémon-themed animation.

## Screenshots
*(Add screenshots of your app here for a visual preview.)*

| Splash Screen | Authentication | Home Screen |
|--------------|----------------|-------------|
| ![Splash Screen](screenshots/splash.png) | ![Auth Screen](screenshots/auth.png) | ![Home Screen](screenshots/home.png) |

## Installation

### Prerequisites
- Flutter SDK (version 3.x.x recommended) - [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart (comes with Flutter)
- A Firebase project set up with Authentication and Firestore enabled - [Firebase Setup](https://firebase.google.com/docs/flutter/setup)
- IDE (e.g., VS Code, Android Studio) with Flutter plugins installed

### Steps
1. **Clone the Repository:**
   ```sh
   git clone https://github.com/yourusername/pokedex-flutter.git
   cd pokedex-flutter
   ```
2. **Install Dependencies:**
   ```sh
   flutter pub get
   ```
3. **Configure Firebase:**
    - Set up a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
    - Enable Email/Password and Google Sign-In providers in Authentication.
    - Add Firestore to your project.
    - Download the `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place them in the appropriate directories:
        - Android: `android/app/`
        - iOS: `ios/Runner/`
    - For web, update `lib/core/env/env.dart` with your Firebase config (e.g., `apiKey`, `projectId`).
4. **Run the App:**
   ```sh
   flutter run
   ```
5. **Build for Production:**
   ```sh
   flutter build apk --release  # Android
   flutter build ios --release  # iOS
   flutter build web             # Web
   ```

## Usage
1. **Launch the App:**
    - Start on the splash screen, which transitions after 2 seconds.
    - If authenticated, you’ll go to the Home screen; otherwise, the Auth screen appears.
2. **Authentication:**
    - Sign in with email/password or Google.
    - Switch between sign-in and sign-up modes.
3. **Pokémon Exploration:**
    - Browse Pokémon in a grid.
    - Use the search bar to filter by name or number.
    - Tap the filter button to sort by name or number.
4. **Debugging:**
    - Check console logs for detailed output (Firebase calls, UI events).
    - View logs on-device with `TalkerScreen` (optional).

## Project Structure
```
pokedex-flutter/
├── android/              # Android-specific files
├── ios/                  # iOS-specific files
├── lib/                  # Main Dart source code
│   ├── core/             # Core utilities and services
│   │   ├── env/              # Environment variables
│   │   ├── logger.dart       # Logging with Talker
│   │   ├── routes/           # App routes
│   │   ├── service/          # Business logic services
│   ├── feature/          # Feature-specific code
│   │   ├── models/           # Data models (e.g., Pokemon.dart)
│   │   ├── screens/          # UI screens
│   ├── firebase_options.dart  # Generated Firebase config
│   └── main.dart         # App entry point
├── assets/               # Static assets
└── pubspec.yaml          # Project dependencies
```

## Technologies
- **Flutter:** Cross-platform UI framework
- **Dart:** Programming language
- **Firebase:** Authentication & Firestore
- **Talker:** Logging and error handling
- **Provider:** State management
- **Wolt Modal Sheet:** Custom modal UI
- **SVG Support:** Vector graphics via `flutter_svg`

## Contributing
1. **Fork the Repository:**
    - Click "Fork" on GitHub and clone your fork locally.
2. **Create a Branch:**
   ```sh
   git checkout -b feature/your-feature-name
   ```
3. **Make Changes:**
    - Follow Dart/Flutter best practices.
    - Update tests if applicable.
4. **Commit and Push:**
   ```sh
   git commit -m "Add your feature description"
   git push origin feature/your-feature-name
   ```
5. **Submit a Pull Request:**
    - Open a PR on GitHub with a clear description.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
- **Author:** [Navid Rahman]
- **Email:** [navidrahman92@gmail.com]
- **GitHub:** [github.com/Navid-Rahman](https://github.com/Navid-Rahman)
- **Issues:** [Report bugs or suggest features](https://github.com/Navid-Rahman/pokedex/issues)
