import 'package:flutter/material.dart';

class XoButton extends StatelessWidget {
  const XoButton({
    super.key,
    required this.symbol,
    required this.onClick,
    required this.index,
  });

  final String symbol;
  final Function onClick;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onClick(index);
        },
        child: symbol.isEmpty
            ? SizedBox(height: double.infinity, width: double.infinity)
            : Image.asset(
                symbol == 'X'
                    ? 'assets/Image/Vector 1.png'
                    : 'assets/Image/Ellipse 2.png',
              ),
      ),
    );
  }
}
