# XO Game

A simple and interactive Tic-Tac-Toe game built with Flutter.

The game allows two players to choose who plays first, play against each other, track their scores, and see the result of each round.

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