import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Add Category"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => context.go("/"),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Expense"),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  selected: false,
                  backgroundColor: const Color.fromARGB(255, 149, 168, 183),
                  onSelected: (bool value) {},
                ),
                const SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                  label: const Text("Income"),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  selected: false,
                  backgroundColor: const Color.fromARGB(255, 149, 168, 183),
                  onSelected: (bool value) {},
                ),
                // Chip(
                //     elevation: 20,
                //     padding: const EdgeInsets.all(8),
                //     backgroundColor: Colors.greenAccent[100],
                //     shadowColor: Colors.black,
                //     label: const Text("Expense")),
                // const SizedBox(width: 10),
                // Chip(
                //     elevation: 20,
                //     padding: const EdgeInsets.all(8),
                //     backgroundColor: Colors.greenAccent[100],
                //     shadowColor: Colors.black,
                //     label: const Text("income")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.all(10.0),
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 149, 164, 192)),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                          height: 80,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/money-income-pana.png")))))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialColorPicker(
                  onColorChange: (Color color) {
                    // Handle color changes
                  },
                  selectedColor: Colors.red),
            ),
          ],
        ));
  }
}
