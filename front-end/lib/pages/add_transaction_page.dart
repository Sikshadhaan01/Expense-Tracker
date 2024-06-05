import 'dart:convert';

import 'package:expense_tracker/services/group_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
   List categoryImages = [
    {
      "imageUrl": "assets/icons8-internet-48.png",
      "categoryName": "Internet",
    },
    {
      "imageUrl": "assets/popcorn.png",
      "categoryName": "Entertainment",
    },
    {
      "imageUrl": "assets/shopping-bag.png",
      "categoryName": "Groceries",
    },
    {
      "imageUrl": "assets/gas.png",
      "categoryName": "fuel",
    },
    {
      "imageUrl": "assets/fast-food.png",
      "categoryName": "food/drink",
    },
    {
      "imageUrl": "assets/icons8-car-100.png",
      "categoryName": "car/bike",
    },
    {
      "imageUrl": "assets/taxi.png",
      "categoryName": "taxi",
    },
    {
      "imageUrl": "assets/lightning_616494.png",
      "categoryName": "Electricity",
    },
    {
      "imageUrl": "assets/trolley.png",
      "categoryName": "shopping",
    },
    {
      "imageUrl": "assets/gas (1).png",
      "categoryName": "gas",
    },
    {
      "imageUrl": "assets/water.png",
      "categoryName": "water",
    },
    {
      "imageUrl": "assets/icons8-rent-96.png",
      "categoryName": "rent",
    },
    {
      "imageUrl": "assets/icons8-house-48.png",
      "categoryName": "house",
    },
    {
      "imageUrl": "assets/maid_320337.png",
      "categoryName": "maid salary",
    },
    {
      "imageUrl": "assets/icons8-gym-94.png",
      "categoryName": "gym",
    },
    {
      "imageUrl": "assets/icons8-video-playlist-64.png",
      "categoryName": "subscription",
    },
    {
      "imageUrl": "assets/beach-chair_3403342.png",
      "categoryName": "vacation",
    },
    {
      "imageUrl": "assets/icons8-health-care-64.png",
      "categoryName": "health care",
    },
    {
      "imageUrl": "assets/icons8-education-48.png",
      "categoryName": "education",
    },
    {
      "imageUrl": "assets/icons8-loan-48.png",
      "categoryName": "loan",
    },
    {
      "imageUrl": "assets/icons8-pets-64.png",
      "categoryName": "pets",
    },
    {
      "imageUrl": "assets/tax1.png",
      "categoryName": "insurance/tax",
    },
    {
      "imageUrl": "assets/icons8-gift-48.png",
      "categoryName": "gifts",
    },
    {
      "imageUrl": "assets/donation_10880437.png",
      "categoryName": "doantion",
    },
    {
      "imageUrl": "assets/icons8-flower-48.png",
      "categoryName": "others",
    },
  ];
  var selectedTransactionType = 'Expense';
  List transTypes = ["Expense", "Income"];
  bool isLoading = false;
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrimaryGroup();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Add Transaction'),),
        body: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffc9f9ff)),
                //  height: 500,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: transTypes.map((type) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(type),
                            // labelStyle: const TextStyle(
                            //     fontWeight: FontWeight.bold, color: Colors.white),
                            selected: selectedTransactionType == type,
                            selectedColor: selectedTransactionType == "Expense"
                                ? Colors.red
                                : Colors.green,
                            // backgroundColor:
                            //     const Color.fromARGB(255, 149, 168, 183),
                            onSelected: (bool selected) {
                              setState(() {
                                selectedTransactionType = type;
                              });
                              debugPrint(selectedTransactionType);
                            },
                          ),
                        );
                      }).toList(),
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
                        // child: const TextField(
                        //   decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.only(left: 5),
                        //       hintText: "Title",
                        //       hintStyle: TextStyle(
                        //           color: Color.fromARGB(255, 149, 164, 192)),
                        //       border: InputBorder.none),
                        // ),
                      ),
                    ),
                    selectedCategory != null
                        ? Text(selectedCategory?['categoryName'])
                        : Text(''),
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
                              child: TextField(
                                controller: _amountController,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
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
                                  // Navigator.pop(context);
                                  openModelSheet1(context);
                                },
                                child: const Text("Select Category"),
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
                        child: isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  addTransaction();
                                },
                                child: const Icon(Icons.check),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   addTransaction() async {
    setState(() {
      isLoading = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var userInfo = json.decode(prefs.getString("userInfo")!);
    print('User Info' + userInfo.toString());

    var obj = {
      "amount": _amountController.text,
      "transactionType": selectedTransactionType,
      "categoryName": selectedCategory?['categoryName'],
      "categoryIcon": selectedCategory?['imageUrl'],
      "userId": userInfo['id'],
      "groupId": primaryGroup?['id'],
      "month": DateTime.now().month.toString(),
      "year": DateTime.now().year.toString()
    };
    var error = validateTransactionObj(obj);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    var response = TransactionService().saveTransaction(obj);
    setState(() {
      isLoading = false;
    });
    print("Response " + response.toString());
  }

  validateTransactionObj(obj) {
    if (obj['groupId'] == null) {
      return "Please add a group first to create transactions";
    }
    if (obj['amount'] == "") {
      return "Amount is required";
    }
    if (obj['categoryName'] == null) {
      return "Please select a category";
    }
    return null;
  }

  var primaryGroup;
  getPrimaryGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = jsonDecode(prefs.getString("userInfo")!);
    var response = await GroupService().getPrimaryGroup(userInfo['id']);
    if (response['result'].isEmpty) return;
    setState(() {
      primaryGroup = response['result'][0];
    });
  }

  var selectedCategory;
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
                            // openModelSheet(context);
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
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = e;
                            });
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                e['imageUrl'],
                                width: 80,
                                height: 70,
                              ),
                              Text(e['categoryName'])
                            ],
                          ),
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
