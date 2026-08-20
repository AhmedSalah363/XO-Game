import 'package:flutter/material.dart';
import 'package:xo_game/Screens/xo_screen.dart';
import 'package:xo_game/Styles/colors.dart';
import 'package:xo_game/Styles/text.dart';
import 'package:xo_game/Utils/app_const.dart';
import 'package:xo_game/Widgets/app_scaffold.dart';

class PickPlayerScreen extends StatelessWidget {
  const PickPlayerScreen({super.key});

  static const routeName = "/PickPlayerScreen";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/Image/Group 4.png'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Pick Who Is Playes First?",
                style: AppTextStyle.white24Normal,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          XoScreen.routeName,
                          arguments: AppConst.x,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Image.asset(
                          'assets/Image/Vector 1.png',
                          height: 148,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          XoScreen.routeName,
                          arguments: AppConst.o,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Image.asset(
                          'assets/Image/Ellipse 2.png',
                          height: 148,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
