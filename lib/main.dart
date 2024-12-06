import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smokeless/pages/Home.dart';
import 'package:smokeless/pages/Personalitation.dart';
import 'firebase_options.dart';
import 'package:smokeless/pages/login.dart';

import 'package:smokeless/pages/Personalitation1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/Home': (context) => Home(),
        '/personalitation': (context) => Personalitation(),
        '/personalitation1' : (context) => SmokingProfilePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

    );
  }
} 



/*
main() {
    // Initialize Flutter app
    runApp(MyApp());
}

// Root widget of the app
MyApp() {
    // Check user's login and onboarding status
    checkUserStatus();
}

// Function to check user status
checkUserStatus() {
    if (isUserLoggedIn()) {
        if (isUserFirstTimeLogin()) {
            // Navigate to Onboarding Page
            navigateTo(OnboardingPage());
        } else {
            // Navigate to Home Page
            navigateTo(HomePage());
        }
    } else {
        // Navigate to Login/Register Page
        navigateTo(LoginRegisterPage());
    }
}

// Function to simulate user login status
isUserLoggedIn() {
    // Check shared preferences or a secure storage for login token
    return fetchLoginToken() != null;
}

// Function to simulate user's first-time login status
isUserFirstTimeLogin() {
    // Check if onboarding flag exists in shared preferences
    return fetchOnboardingStatus() == false;
}

// Login/Register Page
LoginRegisterPage() {
    // Show login and registration options
    if (isRegistering()) {
        // Collect registration details
        String email = collectInput("Enter your email:");
        String password = collectInput("Enter your password:");
        if (registerUser(email, password)) {
            // Save login token
            saveLoginToken();

            // Redirect to Onboarding Page
            navigateTo(OnboardingPage());
        }
    } else {
        // Collect login details
        String email = collectInput("Enter your email:");
        String password = collectInput("Enter your password:");
        if (loginUser(email, password)) {
            // Save login token
            saveLoginToken();

            // Check onboarding status
            checkUserStatus();
        }
    }
}

// Onboarding Page
OnboardingPage() {
    // Collect user's name
    String name = collectInput("Enter your name:");

    // Collect user's gender
    String gender = collectInput("Enter your gender (M/F):");

    // Collect number of cigarettes consumed per day
    int cigarettesPerDay = collectInput("Enter number of cigarettes you consume daily:");

    // Collect price per pack of cigarettes
    double pricePerPack = collectInput("Enter price per pack of cigarettes:");

    // Save onboarding data
    saveUserData(name, gender, cigarettesPerDay, pricePerPack);

    // Mark onboarding as completed
    saveOnboardingStatus();

    // Navigate to Home Page
    navigateTo(HomePage());
}

// Home Page
HomePage() {
    // Display the main content of the app
    showMainContent();
}

// Utility Functions
navigateTo(page) {
    // Simulate page navigation
    print("Navigating to $page");
}

fetchLoginToken() {
    // Simulate fetching login token from storage
    return null; // Assume user isn't logged in
}

fetchOnboardingStatus() {
    // Simulate fetching onboarding status
    return false; // Assume user hasn't completed onboarding
}

saveLoginToken() {
    // Simulate saving login token
    print("Login token saved");
}

saveUserData(name, gender, cigarettesPerDay, pricePerPack) {
    // Simulate saving user data
    print("User Data Saved: $name, $gender, $cigarettesPerDay/day, $pricePerPack/pack");
}

saveOnboardingStatus() {
    // Simulate saving onboarding status
    print("Onboarding status updated to completed");
}

collectInput(prompt) {
    // Simulate user input collection
    print(prompt);
    return "sample_input";
}

registerUser(email, password) {
    // Simulate user registration
    print("User registered with email: $email");
    return true;
}

loginUser(email, password) {
    // Simulate user login
    print("User logged in with email: $email");
    return true;
}

isRegistering() {
    // Simulate checking if user is registering
    return true; // Assume the user is registering
}

showMainContent() {
    // Simulate displaying main content
    print("Welcome to the Home Page");
}
*/