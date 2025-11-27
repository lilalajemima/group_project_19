## Pamoja Volunteering App

A comprehensive Flutter application connecting volunteers with meaningful community service opportunities. Built with Firebase, BLoC state management, and modern Material Design.

## Features 

### For volunteers 

Discover Opportunities - Browse and search volunteer opportunities by category, location, and time commitment
Easy Application - Apply to opportunities with a single tap
Activity Tracking - Track your volunteer journey from application to completion
 Community Feed - Share experiences and connect with other volunteers
Achievements - Earn certificates and track volunteer hours
Real-time Notifications - Stay updated on application status and new opportunities
Save Favorites - Bookmark opportunities for later
Dark Mode - Toggle between light and dark themes

### For administrators 

Create Opportunities - Post new volunteering opportunities with images
Manage Opportunities - Edit or delete existing opportunities
Review Applications - Approve, reject, or mark applications as complete
View Volunteer Profiles - Check volunteer skills, experience, and history
Automatic Notifications - Users receive notifications for new opportunities

### Technical Features 

Secure Authentication - Email/password and Google Sign-In
Cloud Storage - Firebase Firestore for real-time data
BLoC Architecture - Scalable state management
Responsive Design - Works on all screen sizes
Well-Tested - Comprehensive unit and widget tests
Type-Safe - Null-safety enabled

## Set up Instructions 

### Prerequisites
Flutter SDK (>=3.0.0 <4.0.0)
Dart SDK (comes with Flutter)
Android Studio / VS Code
Firebase account
Git

1. Clone the Repository
 git clone https://github.com/yourusername/pamoja_app.git
cd pamoja_app
2. Install Dependencies
flutter pub get

### Firebase Setup 

A. Create a Firebase Project

Go to Firebase Console
Click "Add project"
Enter project name (e.g., "Pamoja App")
Follow the setup wizard

B. Register Android App

In Firebase Console, click the Android icon
Enter package name: com.example.pamoja
Download google-services.json
Place it in android/app/ directory

C. Enable Authentication

In Firebase Console, go to Authentication
Click Get Started
Enable Email/Password authentication
Enable Google sign-in

D. Create Firestore Database

In Firebase Console, go to Firestore Database
Click Create database
Start in production/test mode
Choose a location

E. Configure Firestore Rules
Go to Firestore Rules tab and replace with:

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && request.auth.uid == userId;
      allow update, delete: if request.auth != null && request.auth.uid == userId;
    }
    
    // Opportunities collection
    match /opportunities/{opportunityId} {
      allow read: if request.auth != null;
      allow create, update, delete: if request.auth != null;
    }
    
    // Applications collection
    match /applications/{applicationId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null;
    }
    
    // Posts collection (Community)
    match /posts/{postId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        resource.data.authorId == request.auth.uid;
      
      match /commentsList/{commentId} {
        allow read: if request.auth != null;
        allow create: if request.auth != null;
      }
    }
    
    // Notifications collection
    match /notifications/{notificationId} {
      allow read: if request.auth != null && 
        resource.data.userId == request.auth.uid;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
    
    // Admins collection
    match /admins/{adminEmail} {
      allow read: if request.auth != null;
    }
  }
}

F. Setup Admin Access

In Firestore Database, click + Start collection
Collection ID: admins
Document ID: Your admin email (e.g., admin@pamoja.com)
Add field:

Field: email
Type: string
Value: Your admin email


Add another field:

Field: role
Type: string
Value: admin

### Google Sign-In Setup (Android)
A. Get SHA-1 Certificate
bashcd android
./gradlew signingReport
Copy the SHA-1 certificate fingerprint.
B. Add SHA-1 to Firebase

In Firebase Console, go to Project Settings
Under "Your apps", select your Android app
Click Add fingerprint
Paste the SHA-1 certificate

C. Download Updated google-services.json

In Firebase Console, download the updated google-services.json
Replace the existing file in android/app/

### Run the App
On Emulator/Device
 flutter run
Build APK
 flutter build apk --release

### Running Tests
Run All Tests
flutter test
Run Specific Test File
flutter test test/domain/models/opportunity_test.dart
Run with Coverage
flutter test --coverage

### Troubleshooting
Common Issues
1. Firebase Connection Issues
Problem: App can't connect to Firebase
Solution:

Verify google-services.json is in android/app/
Check package name matches Firebase configuration
Rebuild the app: flutter clean && flutter run

2. Google Sign-In Not Working
Problem: Google sign-in fails
Solution:

Verify SHA-1 certificate is added to Firebase
Download updated google-services.json
Check Google Sign-In is enabled in Firebase Console

3. Build Errors
Problem: Gradle build fails
Solution:
bashcd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run

## Screenshots 

### Authentication & Onboarding 

![Onboarding 1](image-3.png) ![Onboarding 2](image-4.png) ![Onboarding 3](image-5.png)

![Sign up page](image.png) ![Login Page](image-1.png) ![Admin login  page](image-2.png)


### Main Features 

#### Home

![Home](image-6.png) ![Home 2](image-7.png) ![Home 3](image-8.png)

#### Explore

![Explore](image-9.png) 

#### Tracker 

![Tracker](image-10.png) ![Tracker 2](image-25.png)

#### Community 

![Community](image-11.png)

#### Profile 

![Profile 1](image-12.png) ![Profile 2](image-13.png)

#### Settings 

![Settings ](image-14.png)

#### Notifications 

![Notifications](image-24.png)

#### Dark Mode 

![Settings](image-15.png) ![Profile](image-16.png) ![Community](image-17.png) 

![Tracker](image-18.png) ![Explore](image-19.png) ![Home](image-20.png)

### Admin

![New Opportunity](image-21.png) ![Opportunity](image-22.png) ![Applications](image-23.png) 


