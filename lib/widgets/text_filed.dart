import 'package:flutter/material.dart';

import 'palletes.dart';

class Textfeild extends StatelessWidget {
  const Textfeild({
    Key? key,
    required TextEditingController regController,
    required this.hintText,
    this.keyboardType = TextInputType.name,
  })  : _regController = regController,
        super(key: key);

  final TextEditingController _regController;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 340),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            keyboardType: keyboardType,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              } else {
                return null;
              }
            },
            controller: _regController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Pallet.borderColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Pallet.gradient2,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white54)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

const scaffoldBG = Colors.black;
