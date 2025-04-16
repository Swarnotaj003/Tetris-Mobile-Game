# Tetris : A Mobile Game Application 🎮
## About
`Tetris` is a classic puzzle game that challenges players to arrange falling blocks, called `Tetrominoes` into complete lines. This mobile application brings the timeless gameplay of Tetris to your fingertips, allowing you to enjoy the game anytime, anywhere. With intuitive controls, vibrant graphics, and engaging sound effects, Tetris offers a fun and addictive experience for players of all ages.

## Objective
The objective of this project is to build a fully functional `mobile game` using `Flutter` without relying on any third-party packages. This approach emphasizes understanding Flutter's core capabilities and best use of data structure to implement gaming logic.

## Demo
You can download the APK file to install the application on your Android device:
> This will require **granting permission** to *install apps from unknown sources*

[**Download APK**](https://github.com/Swarnotaj003/Tetris-Mobile-Game/releases/download/v1.0/app-release.apk)

## App Preview
Gameplay    |  Game over |
------------|------------|
![image](https://github.com/user-attachments/assets/32f7cbf5-54a6-4f23-b2c9-4c03343bb88c)|![image](https://github.com/user-attachments/assets/f6847704-d910-428f-ad45-a476ca28aeef)


## Getting Started

To run this project locally, follow these steps:

### Prerequisites

- Flutter SDK installed on your device
- An IDE like Android Studio or VS Code
- An Android emulator or a physical device for testing

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/Swarnotaj003/Tetris-Mobile-Game.git
    cd tetris_game
    ```
2. Install the dependencies:
    ```bash
    flutter pub get
    ```
3. Set up Firebase:
    - Create a Firebase project in the Firebase Console.
    - Add your Android app to the Firebase project and download the google-services.json file.
    - Place the google-services.json file in the android/app directory.

4. Configure your app:
    - Update the necessary configurations in android/app/build.gradle and android/build.gradle as per Firebase setup instructions.

5. Run the app:
    ```bash
    flutter run
