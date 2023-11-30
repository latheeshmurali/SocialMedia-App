import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: mobileBackgroundColor,
        middle: SvgPicture.asset(
          'assets/images/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        // trailing: CupertinoButton(
        //   padding: const EdgeInsets.only(top: 0),
        //     child: const Icon(
        //       CupertinoIcons.bubble_right,
        //       color: pinkapple,
        //       size: 25,
        //     ),
        //     onPressed: () {}),
      ),
      child: const PostCard(),
    );
  }
}
