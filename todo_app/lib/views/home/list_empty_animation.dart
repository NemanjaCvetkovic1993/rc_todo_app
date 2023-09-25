import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListAnimation extends StatelessWidget {
  final String listName;
  const EmptyListAnimation({
    super.key,
    required this.listName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 160.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/animation_lmxlx41h.json",
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'List ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  TextSpan(
                    text: listName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  TextSpan(
                    text: ' is empty',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
