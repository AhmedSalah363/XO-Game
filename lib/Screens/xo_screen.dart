import 'dart:async';
import 'package:xo_game/Widgets/game_info.dart';
import 'package:flutter/material.dart';
import 'package:xo_game/Styles/colors.dart';
import 'package:xo_game/Styles/text.dart';
import 'package:xo_game/Utils/app_const.dart';
import 'package:xo_game/Widgets/app_scaffold.dart';
import 'package:xo_game/Widgets/xo_button.dart';
import 'package:xo_game/Widgets/game_result_dialog.dart';

class XoScreen extends StatefulWidget {
  const XoScreen({super.key});

  static const String routeName = '/XoScreen';

  @override
  State<XoScreen> createState() => _XoScreenState();
}

class _XoScreenState extends State<XoScreen> {
  static const int boardSize = 9;

  static const List<List<int>> winningPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  late final String firstPlayer;
  late final String secondPlayer;

  List<String> board = List<String>.filled(boardSize, '');

  Timer? _timer;
  int _elapsedSeconds = 0;
  int _moveCount = 0;

  int _xWins = 0;
  int _oWins = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedPlayer =
          ModalRoute.of(context)?.settings.arguments as String;

      firstPlayer = selectedPlayer;
      secondPlayer = selectedPlayer == AppConst.x ? AppConst.o : AppConst.x;

      _startTimer();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GameInfo(
                formattedTime: _getFormattedTime(),
                xWins: _xWins,
                oWins: _oWins,
              ),
              const SizedBox(height: 16),
              _buildPlayerTurn(),
              const SizedBox(height: 16),
              _buildBoard(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Timer
  // ---------------------------------------------------------------------------

  void _startTimer() {
    _timer?.cancel();

    _elapsedSeconds = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String _getFormattedTime() {
    final minutes = _elapsedSeconds ~/ 60;
    final seconds = _elapsedSeconds % 60;

    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }

  // ---------------------------------------------------------------------------
  // Game Info
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // Player Turn
  // ---------------------------------------------------------------------------

  Widget _buildPlayerTurn() {
    final currentPlayer = _moveCount.isEven ? firstPlayer : secondPlayer;

    return Text(
      'Player ${currentPlayer == firstPlayer ? '1' : '2'}\'s Turn',
      textAlign: TextAlign.center,
      style: AppTextStyle.white36Bold,
    );
  }

  // ---------------------------------------------------------------------------
  // Board
  // ---------------------------------------------------------------------------

  Widget _buildBoard() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildXoButton(0),
                      _buildXoButton(1),
                      _buildXoButton(2),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      _buildXoButton(3),
                      _buildXoButton(4),
                      _buildXoButton(5),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      _buildXoButton(6),
                      _buildXoButton(7),
                      _buildXoButton(8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildHorizontalLines(),
          _buildVerticalLines(),
        ],
      ),
    );
  }

  Widget _buildXoButton(int index) {
    return XoButton(
      symbol: board[index],
      index: index,
      onClick: _onPlayerClick,
    );
  }

  Widget _buildHorizontalLines() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Divider(
          indent: 13,
          endIndent: 13,
          color: AppColors.black,
          thickness: 1,
        ),
        Divider(
          indent: 13,
          endIndent: 13,
          color: AppColors.black,
          thickness: 1,
        ),
      ],
    );
  }

  Widget _buildVerticalLines() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        VerticalDivider(
          indent: 22,
          endIndent: 22,
          color: AppColors.black,
          thickness: 1,
        ),
        VerticalDivider(
          indent: 22,
          endIndent: 22,
          color: AppColors.black,
          thickness: 1,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Game Logic
  // ---------------------------------------------------------------------------

  Future<void> _onPlayerClick(int index) async {
    if (board[index].isNotEmpty) return;

    final currentPlayer = _moveCount.isEven ? firstPlayer : secondPlayer;

    setState(() {
      board[index] = currentPlayer;
      _moveCount++;
    });

    if (_checkWinner(currentPlayer)) {
      _stopTimer();
      _updateScore(currentPlayer);

      await _showGameResult(
        title: '🏆 Winner!',
        message: 'Player $currentPlayer Wins!',
      );

      _resetBoard();
      return;
    }

    if (_moveCount == boardSize) {
      _stopTimer();

      await _showGameResult(title: 'Draw!', message: 'It\'s a draw!');

      _resetBoard();
    }
  }

  bool _checkWinner(String symbol) {
    return winningPatterns.any(
      (pattern) => pattern.every((index) => board[index] == symbol),
    );
  }

  void _updateScore(String winner) {
    if (winner == AppConst.x) {
      _xWins++;
    } else if (winner == AppConst.o) {
      _oWins++;
    }
  }

  // ---------------------------------------------------------------------------
  // Game Result
  // ---------------------------------------------------------------------------

  Future<void> _showGameResult({
    required String title,
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return GameResultDialog(title: title, message: message);
      },
    );
  }
  // ---------------------------------------------------------------------------
  // Reset
  // ---------------------------------------------------------------------------

  void _resetBoard() {
    setState(() {
      board = List<String>.filled(boardSize, '');
      _moveCount = 0;
    });

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
