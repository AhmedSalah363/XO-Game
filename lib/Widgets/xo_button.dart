import 'package:flutter/material.dart';
import 'package:xo_game/Utils/app_const.dart';

class XoButton extends StatelessWidget {
  const XoButton({
    super.key,
    required this.symbol,
    required this.onClick,
    required this.index,
  });

  final String symbol;
  final void Function(int index) onClick;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onClick(index),
        child: symbol.isEmpty
            ? const SizedBox.expand()
            : Image.asset(_getSymbolAsset()),
      ),
    );
  }

  String _getSymbolAsset() {
    if (symbol == AppConst.x) {
      return 'assets/Image/Vector 1.png';
    }

    return 'assets/Image/Ellipse 2.png';
  }
}
