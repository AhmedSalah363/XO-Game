import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xo_game/Styles/colors.dart';
import 'package:xo_game/Styles/text.dart';
import 'package:xo_game/Utils/app_const.dart';
import 'package:xo_game/Widgets/app_scaffold.dart';
import 'package:xo_game/Widgets/xo_button.dart';

class XoScreen extends StatefulWidget {
  const XoScreen({super.key});

  static String routeName = "/XoScreen";

  @override
  State<XoScreen> createState() => _XoScreenState();
}

class _XoScreenState extends State<XoScreen> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  late String firstPlayer;
  late String secoundPlayer;
  int count = 0;
  int xWins = 0;
  int oWins = 0;

  @override
  Widget build(BuildContext context) {
    firstPlayer = ModalRoute.of(context)!.settings.arguments as String;
    secoundPlayer = firstPlayer == AppConst.o ? AppConst.x : AppConst.o;

    return SafeArea(
      child: AppScaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildGameInfo(),
              SizedBox(height: 16),
              buildPlayerTurn(),
              SizedBox(height: 16),
              buildBoard(),
            ],
          ),
        ),
      ),
    );
  }

  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  String gitFormatedTime() {
    int secound = timer.tick;
    int min = timer.tick ~/ 60;
    secound = secound - min * 60;
    return "${min < 10 ? "0$min" : min}:${secound < 10 ? "0$secound" : secound}";
  }

  Text buildPlayerTurn() => Text(
    "Player ${count.isEven ? '1' : '2'}'s Turn",
    textAlign: TextAlign.center,
    style: AppTextStyle.white36Bold,
  );

  Expanded buildBoard() => Expanded(
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
                    XoButton(
                      symbol: board[0],
                      index: 0,
                      onClick: onPlayerClick,
                    ),
                    XoButton(
                      symbol: board[1],
                      index: 1,
                      onClick: onPlayerClick,
                    ),
                    XoButton(
                      symbol: board[2],
                      index: 2,
                      onClick: onPlayerClick,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    XoButton(
                      symbol: board[3],
                      index: 3,
                      onClick: onPlayerClick,
                    ),
                    XoButton(
                      symbol: board[4],
                      index: 4,
                      onClick: onPlayerClick,
                    ),
                    XoButton(
                      symbol: board[5],
                      index: 5,
                      onClick: onPlayerClick,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    XoButton(
                      symbol: board[6],
                      index: 6,
                      onClick: onPlayerClick,
                    ),
                    XoButton(
                      symbol: board[7],
                      index: 7,
                      onClick: onPlayerClick,
                    ),
                    XoButton(
                      symbol: board[8],
                      index: 8,
                      onClick: onPlayerClick,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
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
        ),
        Row(
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
        ),
      ],
    ),
  );

  Future<void> onPlayerClick(int index) async {
    if (board[index].isNotEmpty) return;

    final currentPlayer = count.isEven ? firstPlayer : secoundPlayer;

    setState(() {
      board[index] = currentPlayer;
      count++;
    });

    // Check winner first
    if (checkWinner(currentPlayer)) {
      if (currentPlayer == AppConst.x) {
        xWins++;
      } else {
        oWins++;
      }
      timer.cancel();

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Text("🏆 Winner!", textAlign: TextAlign.center),
            content: Text(
              "Player $currentPlayer Wins!",
              textAlign: TextAlign.center,
              style: AppTextStyle.black32SemiBold,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Play Again"),
              ),
            ],
          );
        },
      );

      resetboard();
      return;
    }

    // No winner + board is full = Draw
    if (count == 9) {
      timer.cancel();

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Text("Draw!", textAlign: TextAlign.center),
            content: const Text(
              "It's a draw!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Play Again"),
              ),
            ],
          );
        },
      );

      resetboard();
    }
  }

  bool checkWinner(String symbol) {
    // Rows
    if (board[0] == symbol && board[1] == symbol && board[2] == symbol) {
      return true;
    }

    if (board[3] == symbol && board[4] == symbol && board[5] == symbol) {
      return true;
    }

    if (board[6] == symbol && board[7] == symbol && board[8] == symbol) {
      return true;
    }

    // Columns
    if (board[0] == symbol && board[3] == symbol && board[6] == symbol) {
      return true;
    }

    if (board[1] == symbol && board[4] == symbol && board[7] == symbol) {
      return true;
    }

    if (board[2] == symbol && board[5] == symbol && board[8] == symbol) {
      return true;
    }

    // Diagonals
    if (board[0] == symbol && board[4] == symbol && board[8] == symbol) {
      return true;
    }

    if (board[2] == symbol && board[4] == symbol && board[6] == symbol) {
      return true;
    }

    return false;
  }

  void resetboard() {
    board = ['', '', '', '', '', '', '', '', ''];
    count = 0;
    timer.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  Widget buildGameInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Timer
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            gitFormatedTime(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),

        // Score
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Text(
                'X: $xWins',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(width: 16),

              Text(
                'O: $oWins',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
