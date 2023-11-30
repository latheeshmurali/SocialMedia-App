import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
import 'package:insta_clone/responsive/responsive_layout_screen.dart';
import 'package:insta_clone/responsive/web_screen_layout.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Flexible(
                //   fit: FlexFit.loose,
                //   child: Container(),
                // ),
                const SizedBox(
                  height: 70,
                ),
                SvgPicture.asset(
                  'assets/images/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(height: 64),
                //avatar
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.cmcaindia.org%2Fwp-content%2Fuploads%2F2015%2F11%2Fdefault-profile-picture-gmail-2.png&f=1&nofb=1&ipt=a0655cf00107006bee80ccd77924f687ff277e207ad2e1587d039143c951726c&ipo=images'),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: pinkapple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                //
                TextFieldInput(
                  textEditingController: _usernameController,
                  isPass: false,
                  hintText: 'Username',
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  textEditingController: _emailController,
                  isPass: false,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                // const SizedBox(height: 24,),
                TextFieldInput(
                  textEditingController: _passwordController,
                  isPass: true,
                  hintText: 'Password',
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  textEditingController: _bioController,
                  isPass: false,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                //button
                ElevatedButton(
                  onPressed: signUpUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 247, 40, 109),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text('Already have an Account?'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 247, 40, 109),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Flexible(
                //   flex: 2,
                //   child: Container(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
