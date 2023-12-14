# Notely: Notes and To-Do App

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/yourusername/notely/LICENSE)

Notely is a cross-platform mobile application built using the Flutter framework and integrated with Firebase for backend support. It offers a seamless and intuitive interface for creating and managing notes and to-do lists.

## Features

- **User Authentication:** Securely sign up and log in to personalize your experience.
- **Notes:** Create, edit, and delete notes effortlessly.
- **To-Do Lists:** Manage your tasks with a user-friendly to-do list feature.
- **Real-time Sync:** Sync your data across devices in real-time with Firebase.

## Screenshots

![Screenshot 1](/screenshots/screenshot1.png)
*Caption for Screenshot 1*

![Screenshot 2](/screenshots/screenshot2.png)
*Caption for Screenshot 2*

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/notely.git
   cd notely

2. **Install dependencies:**

   ```bash
   flutter pub get
   
3. **Configure Firebase:**
   
   * Create a new project on Firebase Console.
   * Add your Android and iOS app to the Firebase project.
   * Download and place the configuration files (google-services.json for Android, GoogleService-Info.plist for iOS) in the respective platform folders.

4. **Run the app:**

   ```bash
   flutter run

## Configuration
To use your own Firebase project, replace the Firebase configuration files in the android/app and ios/Runner folders with the files you downloaded from the Firebase Console.

## Contributing
Contributions are welcome! Please follow the contribution guidelines to get started.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
Special thanks to Flutter and Firebase for making this project possible.
