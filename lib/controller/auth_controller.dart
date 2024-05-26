import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task/models/error_model.dart';
import 'package:task/models/login_response_model.dart';
import 'package:task/pages/main/main_page.dart';

import 'package:task/services/api/auth_service.dart';

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

        box.write('token', response.accessToken);
        log(box.read('token'));

        Get.to(() => MainPage());
      } else if (response is ErrorResponseModel) {
        errorMessage.value = response.message;
        showSnackbar();
      }
    } catch (e) {
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading(false);
    }
  }

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
