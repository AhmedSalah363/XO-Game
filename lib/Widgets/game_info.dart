import 'package:flutter/material.dart';
import 'package:xo_game/Styles/colors.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({
    super.key,
    required this.formattedTime,
    required this.xWins,
    required this.oWins,
  });

  final String formattedTime;
  final int xWins;
  final int oWins;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoContainer(
          child: Text(
            formattedTime,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),
        _buildInfoContainer(
          child: Row(
            children: [
              _buildScore(player: 'X', score: xWins),
              const SizedBox(width: 16),
              _buildScore(player: 'O', score: oWins),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScore({required String player, required int score}) {
    return Text(
      '$player: $score',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildInfoContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}
