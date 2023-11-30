import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
// import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AddPostScreen());

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;

  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  _selectImage(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Center(
          child: Text(
            'Create a post',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Take a photo'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(
                () {
                  _file = file;
                },
              );
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Choose from gallery'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(
                () {
                  _file = file;
                },
              );
            },
          ),
        ],
        cancelButton: CupertinoButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Posted!", context);
        clearImage();
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(
                CupertinoIcons.upload_circle_fill,
              ),
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                padding: EdgeInsets.zero,
                onPressed: clearImage,
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 22,
                ),
              ),
              middle: const Text(
                'Post to',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 21,
                ),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text(
                  'Post',
                  style: TextStyle(
                    color: pinkapple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () =>
                    postImage(user.uid, user.username, user.photoUrl),
              ),
            ),
            child: Column(
              children: [
                _isLoading
                    ? const CupertinoActivityIndicator()
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: CupertinoTextField(
                        controller: _descriptionController,
                        placeholder: 'write a caption...',
                        maxLines: 8,
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                      width: 45.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                              image: MemoryImage(_file!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
          );
  }
}
