import 'package:flutter/material.dart';
import 'package:xo_game/Screens/xo_screen.dart';
import 'package:xo_game/Styles/colors.dart';
import 'package:xo_game/Styles/text.dart';
import 'package:xo_game/Utils/app_const.dart';
import 'package:xo_game/Widgets/app_scaffold.dart';

class PickPlayerScreen extends StatelessWidget {
  const PickPlayerScreen({super.key});

  static const String routeName = '/PickPlayerScreen';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/Image/Group 4.png'),
          _buildPlayerSelection(context),
        ],
      ),
    );
  }

  Widget _buildPlayerSelection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Pick Who Plays First?',
          style: AppTextStyle.white24Normal,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: _buildPlayerCard(
                context: context,
                imagePath: 'assets/Image/Vector 1.png',
                player: AppConst.x,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildPlayerCard(
                context: context,
                imagePath: 'assets/Image/Ellipse 2.png',
                player: AppConst.o,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPlayerCard({
    required BuildContext context,
    required String imagePath,
    required String player,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () {
        Navigator.pushNamed(context, XoScreen.routeName, arguments: player);
      },
      child: Container(
        height: 148,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Image.asset(imagePath),
      ),
    );
  }
}
