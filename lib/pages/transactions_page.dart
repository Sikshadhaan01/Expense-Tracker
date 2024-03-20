import 'package:expense_tracker/configs/CustomColors.dart';
import 'package:expense_tracker/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  List transactions = [
    {
      "transactionType": "Expense",
      "transactionAmount": 1000,
      "transactionName": "Internet Bill"
    },
    {
      "transactionType": "Expense",
      "transactionAmount": 1000,
      "transactionName": "Electricity Bill"
    },
    {
      "transactionType": "Income",
      "transactionAmount": 2000,
      "transactionName": "Interest"
    },
    {
      "transactionType": "Income",
      "transactionAmount": 500,
      "transactionName": "Other"
    },
    {
      "transactionType": "Expense",
      "transactionAmount": 1000,
      "transactionName": "Entertainment"
    },
  ];

  @override
  void initState() {
    super.initState();
    initializeTabs();
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
                                  style: TextStyle(color: CustomColors().primaryColor, letterSpacing: 2, fontWeight: FontWeight.bold),
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
            body: TabBarView(
              controller: _controller,
              children: dateList.map((e) => TransactionListTile(transactions: transactions)).toList(),
            ),
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
        "month": months[currentDate.month - 1]
      };
      yearMonthList.add(yearMonth);
      if(currentDate.year ==  DateTime.now().year && currentDate.month == DateTime.now().month){
        debugPrint("Current date"+currentDate.toString());
        _selectedIndex = yearMonthList.length-1;
      }

      // Move to the next month
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    }

    return yearMonthList;
  }

  initializeTabs(){
     generateYearMonthList(DateTime(2024, 3, 10), DateTime(2030, 3, 10))
        .then((value) {
      setState(() {
        dateList = value;
      });
      _controller = TabController(length: dateList.length, vsync: this, initialIndex: _selectedIndex);
    });
  }
}
