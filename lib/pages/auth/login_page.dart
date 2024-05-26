import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/controller/auth_controller.dart';
import 'package:task/services/api/auth_service.dart';
import 'package:task/utils/constants/app_constants.dart';
import 'package:task/utils/constants/extensions.dart';
import 'package:task/widgets/textfield.dart';

import '../../widgets/common_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final AuthController authController =
    Get.put(AuthController(apiService: AuthService()));
late TextEditingController _usernameController;
late TextEditingController _passwordController;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          60.ph,
          Center(
            child: Image.asset(
              ImagePaths.instagramLogo,
            ),
          ),
          70.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                ),
                15.ph,
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                ),
                15.ph,
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                25.ph,
                Obx(() {
                  if (authController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        AppCommonButton(
                          onPressed: () {
                            authController.errorMessage.value = '';
                            if (_usernameController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              authController.login(
                                  login: _usernameController.text,
                                  password: _passwordController.text);
                            } else {
                              authController.errorMessage.value =
                                  'Please fill in both fields';
                            }
                          },
                        ),
                      ],
                    );
                  }
                }),
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
                      Text(
                        'Sign up.',
                        style: TextStyle(color: Colors.blue),
                      ),
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
