import 'package:expense_tracker/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTransactionBtn extends StatelessWidget {
  AddTransactionBtn({super.key});

  List categoryImages = [
    {
      "imageUrl": "assets/manage-money-pana.png",
      "categoryName": "Internet",
    },
    {
      "imageUrl": "assets/manage-money-pana.png",
      "categoryName": "Entertainment",
    },
    {
      "imageUrl": "assets/manage-money-pana.png",
      "categoryName": "Others",
    },
    {
      "imageUrl": "assets/manage-money-pana.png",
      "categoryName": "Bills",
    },
    {
      "imageUrl": "assets/manage-money-pana.png",
      "categoryName": "Bills",
    },
    {
      "imageUrl": "assets/manage-money-pana.png",
      "categoryName": "Bills",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF1e3557),
      onPressed: () {
        openModelSheet(context);
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  openModelSheet(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffc9f9ff)),
              //  height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Add Transaction",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text("Expense"),
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        selected: false,
                        backgroundColor:
                            const Color.fromARGB(255, 149, 168, 183),
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
                        backgroundColor:
                            const Color.fromARGB(255, 149, 168, 183),
                        onSelected: (bool value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: "Title",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 149, 164, 192)),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: const TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 5),
                                  hintText: "Amount",
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 149, 164, 192)),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                 Navigator.pop(context);
                                openModelSheet1(context);
                              },
                              child: Text("Select Category"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // width: 300,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.check),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  openModelSheet1(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Wrap(children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffc9f9ff)),
            //  height: 500,
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                             Navigator.pop(context);
                            openModelSheet(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const Text(
                        "Select Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);

                            context.go("/categorypage");
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: categoryImages.map((e) {
                        return Column(
                          children: [
                            Image.asset(
                              e['imageUrl'],
                              width: 80,
                              height: 70,
                            ),
                            Text(e['categoryName'])
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          )
        ]);
      },
    );
  }
}
