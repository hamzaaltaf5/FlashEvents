import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../screens/login_screen.dart';
import '../utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _linenumberController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _linenumberController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery, 100);
    setState(() {
      _image = im;
    });
  }

  void SignUpUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      linenumber: _linenumberController.text,
      file: _image!,
    );

    setState(() {
      _isloading = false;
    });

    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white60,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                //Background Container
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 110.0, left: 20.0),
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Color(0xFF004D40), Color(0xFF009688)])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SignUp',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Register Here',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white60),
                        )
                      ],
                    ),
                  ),
                ),

                //Name of the Application
                Positioned(
                  top: 50,
                  left: 95,
                  child: RichText(
                    text: TextSpan(
                        text: 'Flash',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                              text: 'Events.',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                  ),
                ),

                //Container for the SignUp Information
                Positioned(
                  top: 170.0,
                  child: Container(
                    height: 430,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 5,
                            spreadRadius: 2,
                          )
                        ]),
                    child: Column(
                      children: [
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        TextFieldInput(
                          hintText: 'Enter Your Username',
                          textEditingController: _usernameController,
                          textInputType: TextInputType.name,
                          icon: Icon(Icons.person_outline_rounded),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFieldInput(
                          hintText: 'Enter Your Email',
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress,
                          icon: Icon(Icons.email_outlined),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFieldInput(
                          hintText: 'Enter Your Password',
                          textEditingController: _passwordController,
                          textInputType: TextInputType.visiblePassword,
                          icon: Icon(Icons.password),
                          isPass: true,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFieldInput(
                          hintText: 'Enter Your Phone Number',
                          textEditingController: _linenumberController,
                          textInputType: TextInputType.phone,
                          icon: Icon(Icons.numbers),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFieldInput(
                          hintText: 'Enter Your Bio',
                          textEditingController: _bioController,
                          textInputType: TextInputType.text,
                          icon: Icon(Icons.edit),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        InkWell(
                          onTap: SignUpUser,
                          child: _isloading
                              ? Center(
                            child: CircularProgressIndicator(),
                          )
                              : Container(
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Flexible(
                          child: Container(),
                          flex: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text('Already have an account?'),
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              },
                              child: Container(
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 110,
                  left: 135,
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                        backgroundImage: MemoryImage(_image!),
                        radius: 40.0,
                      )
                          : CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                        radius: 40.0,
                      ),
                      Positioned(
                        bottom: -10,
                        left: 40.0,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
