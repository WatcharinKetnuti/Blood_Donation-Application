import 'package:blood_donation_application/controllers/cache_manager.dart';
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
                child: Form(
                  key: registerController.formKey,
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
                        controller: registerController.firstName,
                        validator: registerController.validateFirstName,
                        decoration: const InputDecoration(
                          labelText: 'ชื่อ',
                          hintText: 'กรอกชื่อของคุณ',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        controller: registerController.lastName,
                        validator: registerController.validateLastName,
                        decoration: const InputDecoration(
                          labelText: 'นามสกุล',
                          hintText: 'กรอกนามสกุลของคุณ',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        controller: registerController.email,
                        validator: registerController.validateEmail,
                        decoration: const InputDecoration(
                          labelText: 'อีเมล',
                          hintText: 'กรอกอีเมล',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        controller: registerController.password,
                        validator: registerController.validatePassword,
                        decoration: const InputDecoration(
                          labelText: 'รหัสผ่าน',
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        controller: registerController.confirmPassword,
                        validator: registerController.validateConfirmPassword,
                        decoration: const InputDecoration(
                          labelText: 'ยืนยันรหัสผ่าน',
                          hintText: 'กรอกรหัสผ่านให้ตรงกัน',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      TextFormField(
                        controller: registerController.birthdate,
                        validator: registerController.validateBirthdate,
                        decoration: const InputDecoration(
                          labelText: 'วันเกิด',
                          hintText: 'กรอกวันเกิดของคุณ',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            registerController.birthdate.text =
                                pickedDate.toString().split(' ')[0];
                          }
                        },
                      ),
                      _gap(),
                      TextFormField(
                        controller: registerController.tel,
                        validator: registerController.validateTel,
                        decoration: const InputDecoration(
                          labelText: 'เบอร์โทร',
                          hintText: 'กรอกเบอร์โทรของคุณ',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      _gap(),
                      DropdownButtonFormField<String>(
                        value: registerController.bloodType.text = 'A',
                        items: <String>['A', 'B', 'AB', 'O']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'กรุ๊ปเลือด',
                          hintText: 'กรุ๊ปเลือดของคุณ',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? newValue) {
                          registerController.bloodType.text = newValue!;
                        },
                      ),
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
                          onPressed: () {
                            if (registerController.formKey.currentState!
                                .validate()) {
                              registerController.register();
                            }
                          },
                        ),
                      ),
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
                      Obx(() => registerController.errorMessage.value.isNotEmpty
                          ? Text(
                              registerController.errorMessage.value,
                              style: TextStyle(color: Colors.red),
                            )
                          : SizedBox.shrink()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _gap() => const SizedBox(height: 16);
}
