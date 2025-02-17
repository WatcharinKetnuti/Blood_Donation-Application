import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body: Center(
          child: Card(
            elevation: 8,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              constraints: MediaQuery.of(context).size.width > 600
                  ? const BoxConstraints(maxWidth: 450)
                  : const BoxConstraints(maxWidth: 350),
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
                        "กรุณากรอกข้อมูลของคุณ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ชื่อ',
                        hintText: 'กรอกชื่อของคุณ',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'นามสกุล',
                        hintText: 'กรอกนามสกุลของคุณ',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'อีเมล',
                        hintText: 'กรอกอีเมล',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'รหัสผ่าน',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    _gap(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'ยืนยันรหัสผ่าน',
                        hintText: 'กรอกรหัสผ่านให้ตรงกัน',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    _gap(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'วันเกิด',
                        hintText: 'กรอกวันเกิดของคุณ',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    _gap(),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'เบอร์โทร',
                        hintText: 'กรอกเบอร์โทรของคุณ',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    _gap(),
                    Obx(() => DropdownButtonFormField<String>(
                          value: registerController.bloodType.value.isEmpty
                              ? null
                              : registerController.bloodType.value,
                          onChanged: (value) =>
                              registerController.bloodType.value = value ?? '',
                          decoration: InputDecoration(
                            labelText: 'กรุ๊ปเลือด',
                            border: OutlineInputBorder(),
                          ),
                          items: ['A', 'B', 'AB', 'O'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),

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
                            'Sign up',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ),
                        onPressed: () {},
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
                            'Back to Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        //   Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         TextField(
        //           onChanged: (value) => registerController.firstName.value = value,
        //           decoration: InputDecoration(
        //             labelText: 'First Name',
        //             border: OutlineInputBorder(),
        //           ),
        //         ),
        //         SizedBox(height: 16),
        //         TextField(
        //           onChanged: (value) => registerController.lastName.value = value,
        //           decoration: InputDecoration(
        //             labelText: 'Last Name',
        //             border: OutlineInputBorder(),
        //           ),
        //         ),
        //         SizedBox(height: 16),
        //         TextField(
        //           onChanged: (value) => registerController.email.value = value,
        //           decoration: InputDecoration(
        //             labelText: 'Email',
        //             border: OutlineInputBorder(),
        //           ),
        //         ),
        //         SizedBox(height: 16),
        //         TextField(
        //           onChanged: (value) => registerController.password.value = value,
        //           obscureText: true,
        //           decoration: InputDecoration(
        //             labelText: 'Password',
        //             border: OutlineInputBorder(),
        //           ),
        //         ),
        //         SizedBox(height: 16),
        //         TextField(
        //           onChanged: (value) => registerController.confirmPassword.value = value,
        //           obscureText: true,
        //           decoration: InputDecoration(
        //             labelText: 'Confirm Password',
        //             border: OutlineInputBorder(),
        //           ),
        //         ),
        //         SizedBox(height: 16),
        //         TextField(
        //           onChanged: (value) => registerController.birthdate.value = value,
        //           decoration: InputDecoration(
        //             labelText: 'Birthdate',
        //             border: OutlineInputBorder(),
        //           ),
        //         ),
        //         SizedBox(height: 16),
        //         TextField(
        //           onChanged: (value) => registerController.tel.value = value,
        //           decoration: InputDecoration(
        //             labelText: 'Tel',
        //             border: OutlineInputBorder(),
        //           ),
        //         ),
        //         SizedBox(height: 16),
        //         Obx(() => DropdownButtonFormField<String>(
        //           value: registerController.bloodType.value.isEmpty ? null : registerController.bloodType.value,
        //           onChanged: (value) => registerController.bloodType.value = value ?? '',
        //           decoration: InputDecoration(
        //             labelText: 'Blood Type',
        //             border: OutlineInputBorder(),
        //           ),
        //           items: ['A', 'B', 'AB', 'O'].map((String value) {
        //             return DropdownMenuItem<String>(
        //               value: value,
        //               child: Text(value),
        //             );
        //           }).toList(),
        //         )),
        //         SizedBox(height: 16),
        //         Obx(() => registerController.isLoading.value
        //             ? CircularProgressIndicator()
        //             : ElevatedButton(
        //           onPressed: registerController.register,
        //           child: Text('Register'),
        //         )),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }

  Widget _gap() => const SizedBox(height: 16);
}
