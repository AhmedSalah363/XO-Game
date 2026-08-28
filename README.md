# XO Game

<<<<<<< HEAD
A Flutter Tic-Tac-Toe game with player selection, timer, score tracking, winner detection, and draw handling.

## Features

- Player selection
- Tic-Tac-Toe gameplay
- Winner detection
- Draw detection
- Game timer
- Win counter
- Play again

## Technologies

- Flutter
- Dart

## Project Structure

```text
XO-Game/
├── android/
├── assets/
├── ios/
├── lib/
│   ├── Screens/
│   ├── Styles/
│   ├── Utils/
│   └── Widgets/
├── test/
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```
=======
A simple and interactive Tic-Tac-Toe game built with Flutter.
>>>>>>> feature/refactor-xo-game

The game allows two players to choose who plays first, play against each other, track their scores, and see the result of each round.

<<<<<<< HEAD
Prerequisites

Make sure you have Flutter installed on your machine.

You can verify your Flutter installation by running:

flutter doctor
Installation

Clone the repository:

git clone https://github.com/AhmedSalah363/XO-Game.git

Navigate to the project directory:

cd XO-Game

Install the project dependencies:

flutter pub get

Run the application:

flutter run
How to Play
Launch the application.
Choose whether X or O plays first.
Players take turns selecting cells on the board.
The first player to complete a row, column, or diagonal wins.
If all cells are filled without a winner, the round ends in a draw.
The winner's score is automatically updated.
Press Play Again to start a new round.
Screenshots
Player Selection
<p align="center"> <img src="screenshots/player_selection.png" width="250"> </p>
Game Screen
<p align="center"> <img src="screenshots/game_screen.png" width="250"> </p>
Winner
<p align="center"> <img src="screenshots/winner.png" width="250"> </p>
Draw
<p align="center"> <img src="screenshots/draw.png" width="250"> </p>
Author

Ahmed Salah

Flutter Developer

GitHub: AhmedSalah363
=======
## Features

- Player selection
- Two-player Tic-Tac-Toe gameplay
- X and O turn management
- Winner detection
- Draw detection
- Game timer
- Win counter
- Play Again functionality
- Clean and simple user interface

## Technologies

- Flutter
- Dart

## Project Structure

```text
XO-Game/
├── android/
├── assets/
├── ios/
├── lib/
│   ├── Screens/
│   │   ├── pick_player_screen.dart
│   │   └── xo_screen.dart
│   │
│   ├── Styles/
│   │   ├── colors.dart
│   │   └── text.dart
│   │
│   ├── Utils/
│   │   └── app_const.dart
│   │
│   └── Widgets/
│       ├── app_scaffold.dart
│       ├── game_info.dart
│       ├── game_result_dialog.dart
│       └── xo_button.dart
│
├── screenshots/
│   ├── player_selection.png
│   ├── game_screen.png
│   ├── winner.png
│   └── draw.png
│
├── test/
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
>>>>>>> feature/refactor-xo-game
