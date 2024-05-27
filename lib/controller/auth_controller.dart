import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task/models/error_model.dart';
import 'package:task/models/login_response_model.dart';
import 'package:task/pages/main/main_page.dart';

import 'package:task/services/auth/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>();
  var errorMessage = ''.obs;
  final AuthService apiService;
  final box = GetStorage();

  AuthController({required this.apiService});

  Future<void> login({required String login, required String password}) async {
    isLoading(true);
    try {
      var response = await apiService.login(login: login, password: password);
      if (response is LoginResponseModel) {
        user.value = response.user;

        saveToken(response.accessToken ?? '');

        Get.to(() => const MainPage());
      } else if (response is ErrorResponseModel) {
        handleErrorResponse(response.message);
      }
    } catch (e) {
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading(false);
    }
  }

  //! save token and add to all get request
  void saveToken(String token) {
    box.write('token', token);
    log('token saved: ${box.read('token')}');
  }

  //! if user write not correct email or password show snackbar
  void handleErrorResponse(String message) {
    errorMessage.value = message;
    showSnackbar();
  }

  //! if user write not correct email or password show snackbar
  SnackbarController showSnackbar() {
    return Get.snackbar(
      'Error',
      'Email or Password Is not correct!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
