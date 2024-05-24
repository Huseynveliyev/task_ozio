import 'package:flutter/material.dart';
import 'package:task/screens/main/main.dart';
import 'package:task/utils/constants/app_constants.dart';

import 'package:get_it/get_it.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

late TextEditingController _usernameController;
late TextEditingController _passwordController;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _usernameController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

Widget   _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: Image.asset(
              ImagePaths.instagramLogo,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                LoginButton(onPressed: () {
                  print(_usernameController.text); 
                    print(_passwordController.text); 
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainScreen()
                      
                    ));
                  
                },),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: Image.asset(
                    ImagePaths.facebookLogin,
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: _buildDivider()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Color.fromARGB(255, 139, 139, 139),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildDivider(),
                    ),
                  ],
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an account? '),
                      
                      Text('Sign up.', style: TextStyle(color: Colors.blue),),
                    ],
                  ),
                ), 
            
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: _buildDivider(),
                ), 
                
                const Text('Instagram от Facebook')
              ],
              
            ),
            
            
          ),
      
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(
      color: Color(0xfff2f2f2),
      thickness: 2,
      height: 5,
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      leading: const Icon(
        Icons.chevron_left_outlined,
        size: 30,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
   const LoginButton({
    super.key,required  this.onPressed
  });
 final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff3797ef),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller, required this.labelText,
  });
  final String labelText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFAFAFA),
      child: TextField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
       controller:controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 14),
          labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0.4,
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0.4,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0.4,
                color: Colors.blue,
              ),
            ),
            ),
      ),
    );
  }
}
