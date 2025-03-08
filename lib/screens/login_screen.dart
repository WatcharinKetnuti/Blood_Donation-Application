import 'package:blood_donation_application/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Form(
        key: loginController.formKey,
        child: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 350),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FlutterLogo(size: 100),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Blood Donation",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Enter email and password.",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      controller: loginController.email,
                      validator: loginController.validateEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'อีเมล',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    Obx(() => TextFormField(
                          controller: loginController.password,
                          validator: loginController.validatePassword,
                          obscureText: !loginController.isPasswordVisible.value,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    loginController.isPasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                onPressed: () {
                                  loginController.togglePasswordVisibility();
                                },
                              )
                          ),
                        )
                    ),
                    _gap(),
                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ),
                        onPressed: () {
                          if (loginController.formKey.currentState!.validate()) {
                            loginController.login();
                          }
                        },
                      ),
                    ),
                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                          onPressed: () {
                            Get.to(() => RegisterScreen());
                          }
                      ),
                    ),
                    _gap(),
                    Obx(() => loginController.isLoading.value ?
                        CircularProgressIndicator()
                        : SizedBox()
                    ),

                    Obx(() => loginController.errorMessage.value.isNotEmpty ?
                        Text(
                            loginController.errorMessage.value,
                            style: TextStyle(color: Colors.red),
                        )
                        : SizedBox()
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
