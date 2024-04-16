import 'package:flutter/material.dart';

void errorSnackbar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 3000),
      dismissDirection: DismissDirection.none,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            padding: const EdgeInsets.all(24),
            height: 90,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0XFF800020),
              image: DecorationImage(
                image: AssetImage('asset/images/skull-background.png'),
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                repeat: ImageRepeat.repeat,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Oh! Snap",
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Alata',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        // 'Blank Canvas, Ready to Be Filled with Your Productivity!',
                        errorMessage,
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: const TextStyle(
                          fontFamily: 'Alata',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          color: Color(0xFFFFFFFF),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -19,
            left: 0,
            child: Image.asset(
              'asset/images/bubble.png',
              height: 40,
              width: 40,
            ),
          ),
        ]),
      ),
    ),
  );
}
