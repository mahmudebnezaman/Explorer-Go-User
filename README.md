# explorergouser

A shared based trip booking application.

# UI Designs:
![1](https://github.com/mahmudebnezaman/Explorer-Go-User/assets/89069368/6891557b-41af-4357-b8ac-0f99f97c5196)
![2](https://github.com/mahmudebnezaman/Explorer-Go-User/assets/89069368/ad4bc7b7-c103-4bb6-b082-b890c2879c5e)
![3](https://github.com/mahmudebnezaman/Explorer-Go-User/assets/89069368/f9dc59cb-32a1-48e1-94b6-a77968734993)
![4](https://github.com/mahmudebnezaman/Explorer-Go-User/assets/89069368/91df7c84-b267-445f-8077-faa007968146)
![5](https://github.com/mahmudebnezaman/Explorer-Go-User/assets/89069368/5ee83e87-2d73-4811-b0d5-8a391fed8abe)
![6](https://github.com/mahmudebnezaman/Explorer-Go-User/assets/89069368/af18a9f0-9cde-4110-add8-2f98b952f6c2)

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Getting Started with Firebase

To add an Android project to Firebase, you'll need to follow these steps:

Set up a Firebase project:

1. Go to the Firebase Console (https://console.firebase.google.com/) and create a new project or select an existing one.
Follow the on-screen instructions to configure the project settings.
Register your app with Firebase:

2. In the Firebase Console, select your project.
Click on the "Add app" button and select the Android platform.
Provide the necessary details for your Android app, such as package name and app nickname.
Download the Firebase configuration files:

3. After registering your app, Firebase will generate a google-services.json file containing your app's Firebase configuration.
Download this file and place it in the app module of your Android project (typically under the app/ directory).
Add Firebase SDK dependencies:

4. Open your project's build.gradle file (located in the project's root directory) and add the following classpath dependency to the buildscript section:

dependencies {
    // ...
    classpath 'com.google.gms:google-services:4.3.10'
    // ...
}

5. Add Firebase SDK to your app module:

Open the build.gradle file for your app module (usually app/build.gradle).
Add the following line at the bottom of the file to apply the Firebase plugin:

apply plugin: 'com.google.gms.google-services'
Sync your project:

6. After making changes to the build.gradle files, sync your project with the Gradle files to ensure the dependencies are downloaded and applied.
Test the Firebase integration:

You can now start using Firebase in your Android app. You can add Firebase features such as Firebase Authentication, Realtime Database, Firestore, Cloud Messaging, etc., based on your requirements.
Remember to follow any additional setup steps specific to the Firebase features you want to use in your app. The Firebase documentation (https://firebase.google.com/docs) provides detailed guides and code samples for each Firebase feature.
