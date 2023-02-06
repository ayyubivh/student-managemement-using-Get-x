import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/controller/screen_controller.dart';
import 'package:student_app/db/models/student_model.dart';
import 'package:student_app/screens/screen_home.dart';
import 'package:student_app/widgets/text_filed.dart';

import '../widgets/palletes.dart';

class Addstudent extends StatelessWidget {
  Addstudent({Key? key, this.data}) : super(key: key);

  final StudentModel? data;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _regController = TextEditingController();
  final _batchController = TextEditingController();

  final screenController = Get.put(ScreenController());
  final formvalidationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBG,
      body: SafeArea(
        child: Column(children: [
          Image.asset('assets/images/signin_balls.png'),
          const Text(
            ' Add User ',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          Expanded(
            child: Form(
              key: formvalidationKey,
              child: ListView(
                children: [
                  GetBuilder<ScreenController>(builder: (controller) {
                    return Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/signin_balls.png"))),
                        child: screenController.stringOfimg.trim().isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(
                                    const Base64Decoder()
                                        .convert(screenController.stringOfimg)),
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/blank-profile-picture-973460_1280.webp'),
                              ),
                      ),
                    );
                  }),
                  IconButton(
                      onPressed: () async {
                        screenController.pickimage();
                      },
                      icon: const Icon(Icons.camera,
                          color: Colors.grey, size: 30)),
                  const SizedBox(height: 10),
                  Textfeild(
                    regController: _nameController,
                    hintText: "Name",
                    keyboardType: TextInputType.name,
                  ),
                  Textfeild(
                      regController: _ageController,
                      hintText: "Age",
                      keyboardType: TextInputType.number),
                  Textfeild(
                      regController: _placeController,
                      hintText: "Place",
                      keyboardType: TextInputType.text),
                  Textfeild(
                      regController: _batchController,
                      hintText: "Batch",
                      keyboardType: TextInputType.text),
                  Textfeild(
                    regController: _regController,
                    hintText: "Reg No",
                    keyboardType: TextInputType.number,
                  ),
                  AddButton(context)
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

// add button
  Center AddButton(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Pallet.gradient1, Pallet.gradient2, Pallet.gradient3],
              begin: Alignment.bottomLeft),
          borderRadius: BorderRadius.circular(7),
        ),
        child: ElevatedButton(
          onPressed: () {
            if (formvalidationKey.currentState!.validate()) {
              addbuttonclick(context);
            }
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(337, 53),
              backgroundColor: Colors.transparent),
          child: const Text(
            'Add',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
      ),
    );
  }

  Future<void> addbuttonclick(BuildContext context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final place = _placeController.text;
    final batch = _batchController.text;
    final reg = _regController.text;

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        batch.isEmpty ||
        reg.isEmpty) {
      return;
    } else if (screenController.stringOfimg.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Choose an image'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
      ));
    } else {
      final student = StudentModel(
        age: age,
        batch: batch,
        name: name,
        place: place,
        regNo: reg,
        image: screenController.stringOfimg,
      );
      screenController.addstudentData(student);
      Get.snackbar("Added", "Data added successfully", colorText: Colors.amber);
      screenController.allStudentslist();
      clearFields();
      Get.offAll(() => HomeScreen());
    }
  }

  void clearFields() {
    _nameController.text = '';
    _ageController.text = '';
    _placeController.text = '';
    _batchController.text = '';
    _regController.text = '';
    screenController.stringOfimg = '';
  }
}
