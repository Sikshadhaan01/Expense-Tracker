import 'package:expense_tracker/services/category_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends StatelessWidget {
  String selectedColor = '';
  TextEditingController nameController = TextEditingController();
  CategoryPage({super.key});

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
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
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
                          image: AssetImage("assets/money-income-pana.png"))),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialColorPicker(
                onColorChange: (Color color) {
                  selectedColor = color.value.toString();
                  // Handle color changes
                },
                selectedColor: Colors.red),
          ),
          ElevatedButton(
            child: Text("Submit"),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe53946)),
            onPressed: () async {
              // if (_formKey.currentState!.validate()) {
              var jsonObj = {
                "categoryName": nameController.text,
                "categoryIcon": "",
                "categoryColor": selectedColor
              };
              var response = await CategoryService().addCategory(jsonObj);
              print(response);
              if (response['message'] == 'category added Success') {
                context.go('/');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('failed Credential'),
                  ),
                );
              }
              // }
            },
          ),
        ],
      ),
    );
  }
}

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _categorynameController = TextEditingController();
  TextEditingController _categoryiconController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // expands: true,
            controller: _categorynameController,
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
                errorStyle: Theme.of(context).textTheme.labelSmall,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.email),
                suffixIconColor: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'category name empty';
              }
              return null;
            },
          ),
          TextFormField(
            style: Theme.of(context).textTheme.labelMedium,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // expands: true,
            controller: _categoryiconController,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                errorStyle: Theme.of(context).textTheme.labelSmall,
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.lock_open),
                suffixIconColor: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'category icon empty';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
