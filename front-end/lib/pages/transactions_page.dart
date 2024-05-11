import 'dart:convert';

import 'package:expense_tracker/components/add_transaction_btn.dart';
import 'package:expense_tracker/configs/CustomColors.dart';
import 'package:expense_tracker/pages/homepage.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  List dateList = [];
  late final TabController _controller;
  int _selectedIndex = 0;
  List transactions = [];

  @override
  void initState() {
    super.initState();
    initializeTabs();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(dateList.toString());
    return dateList.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                controller: _controller,
                isScrollable: true,
                tabs: dateList
                    .map((date) => Tab(
                          // height: 200,
                          // icon: Icon(Icons.ac_unit_outlined),
                          child: SizedBox(
                            // height: 150,
                            child: Column(
                              children: [
                                Text(
                                  date['month'],
                                  style: TextStyle(
                                      color: CustomColors().primaryColor,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(date['year'])
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              title: const Text('Transactions'),
            ),
            body: transactions.isNotEmpty ? TabBarView(
              controller: _controller,
              children: dateList
                  .map((e) => TransactionListTile(transactions: transactions))
                  .toList(),
            ) :const Center(child: Text("No transactions found"),),
            floatingActionButton: AddTransactionBtn(),
          )
        : CircularProgressIndicator(
            color: CustomColors().primaryColor,
          );
  }

  Future<List<Map<String, String>>> generateYearMonthList(
      DateTime startDate, DateTime endDate) async {
    List<Map<String, String>> yearMonthList = [];
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    DateTime currentDate = startDate;

    // DateTime endDate = DateTime.now();

    while (currentDate.isBefore(endDate)) {
      // debugPrint(currentDate.month.toString());
      Map<String, String> yearMonth = {
        "year": currentDate.year.toString(),
        "month": months[currentDate.month - 1],
        "monthIndex": (currentDate.month - 1).toString()
      };
      yearMonthList.add(yearMonth);
      if (currentDate.year == DateTime.now().year &&
          currentDate.month == DateTime.now().month) {
        debugPrint("Current date" + currentDate.toString());
        _selectedIndex = yearMonthList.length - 1;
      }

      // Move to the next month
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    }

    return yearMonthList;
  }

  initializeTabs() {
    generateYearMonthList(DateTime(2024, 3, 10), DateTime(2030, 3, 10))
        .then((value) {
      setState(() {
        dateList = value;
      });
      _controller = TabController(
          length: dateList.length, vsync: this, initialIndex: _selectedIndex);
    _controller.addListener(getTransaction);
    });
  }

  getTransaction() async {
    var selectedMonthAndYear = dateList[_controller.index+1];
    var obj = {
      "month": "${selectedMonthAndYear['monthIndex']}",
      "year": "${selectedMonthAndYear['year']}",
      "userId": "${userInfo['id']}",
      "transType": ""
    };
    var response = await TransactionService().getUserTransactions(obj);
     setState(() {
      transactions = response['result'];
    });
  }

  var userInfo;
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = json.decode(prefs.getString("userInfo")!);
    getTransaction();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
