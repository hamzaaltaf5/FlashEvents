import '../screens/signup_screen.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void LoginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if(res == 'success'){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      _isloading = false;
    });
    //
    // if(res != 'success'){
    //   showSnackBar(context, res);
    // }
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
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Login to your account',
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

                //Container for the Login Information
                Positioned(
                  top: 170.0,
                  child: Container(
                    height: 300,
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
                        TextFieldInput(
                          hintText: 'Enter Your Email',
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress,
                          icon: Icon(Icons.email_outlined),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFieldInput(
                          hintText: 'Enter Your Password',
                          textEditingController: _passwordController,
                          textInputType: TextInputType.visiblePassword,
                          icon: Icon(Icons.password),
                          isPass: true,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: LoginUser,
                          child: Container(
                            child: _isloading? Center(child: CircularProgressIndicator(color: Colors.white,),): Text(
                              'Login',
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
                              child: Text('Don\'t have an account?'),
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                              },
                              child:  Container(
                                child:  Text(
                                  'Signup',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
