import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapercave.com%2Fwp%2Fwp2599594.jpg&f=1&nofb=1&ipt=39b673dfdc1717a0302728f450d93e09c7f8c6bb5ca9cb4965f6907f1e69c583&ipo=images'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'username',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CupertinoButton(
                  child: const Icon(CupertinoIcons.ellipsis_vertical_circle),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        content: Column(
                          children: ['Delete']
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    // Handle delete action here
                                    // You can add your delete logic here
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          //image section
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapercave.com%2Fwp%2Fwp2599594.jpg&f=1&nofb=1&ipt=39b673dfdc1717a0302728f450d93e09c7f8c6bb5ca9cb4965f6907f1e69c583&ipo=images',
                fit: BoxFit.cover,
              ),
            ),
          ),

          //like,comment
          Row(
            children: [
              CupertinoButton(
                child: const Icon(CupertinoIcons.heart),
                onPressed: () {},
              ),
              CupertinoButton(
                child: const Icon(CupertinoIcons.chat_bubble_text),
                onPressed: () {},
              ),
              CupertinoButton(
                child: const Icon(CupertinoIcons.share),
                onPressed: () {},
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CupertinoButton(
                    child: const Icon(CupertinoIcons.bookmark),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),

          //descriprtion and no of comments
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '1234 likes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'username',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  this is some description to be placed',
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all 200 comments',
                      style: const TextStyle(
                        fontSize: 14,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '21/1/2000',
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 13
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
