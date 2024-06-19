import 'dart:convert';

import 'package:expense_tracker/components/add_transaction_btn.dart';
import 'package:expense_tracker/configs/CustomColors.dart';
import 'package:expense_tracker/services/group_service.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double currentAmount = 10000;
  double budgetTotal = 20000;
  int daysLeftInMonth = 0;
  @override
  void initState() {
    // TODO: implement initState
    setDaysLeftInMonth();
    getPrimaryGroup();
    super.initState();
  }

  setDaysLeftInMonth() {
    DateTime now = DateTime.now();
    int totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;
    setState(() {
      daysLeftInMonth = totalDaysInMonth - now.day;
    });
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    GestureDetector(
                        onTap: () {
                          logout();
                        },
                        child: const Icon(Icons.logout))
                  ],
                ),
              ),
              primaryGroup != null
                  ? Card(
                      color: CustomColors().primaryColor,
                      // elevation: 8,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: CustomColors().secondaryColor,
                                width: 3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: CustomColors().secondaryColor,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      primaryGroup['groupName'],
                                      style: TextStyle(
                                          color:
                                              CustomColors().primaryTextColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${formatAmount(primaryGroup['currentAmount'])}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: CustomColors()
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    " left of ${formatAmount(primaryGroup['groupBudget'])}",
                                                style: TextStyle(
                                                    color: CustomColors()
                                                        .primaryTextColor))
                                          ],
                                          style: TextStyle(
                                              // fontSize: 18,
                                              color: CustomColors()
                                                  .secondaryColor)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LinearPercentIndicator(
                              percent: getPercentile(),
                              lineHeight: 18.0,
                              barRadius: const Radius.circular(3),
                              center: Text(
                                "${double.parse(primaryGroup['currentAmountInPercent']).toStringAsFixed(1) * 1}%",
                                style: const TextStyle(fontSize: 12.0),
                              ),
                              // trailing: Icon(Icons.mood),
                              // linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: Colors.grey,
                              progressColor: Colors.white,
                            ),
                            // const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "You can spend ",
                                      style: TextStyle(
                                          color:
                                              CustomColors().primaryTextColor)),
                                  TextSpan(
                                      text:
                                          "${(double.parse(primaryGroup['currentAmount']) / daysLeftInMonth).toStringAsFixed(1)}/day ",
                                      style: TextStyle(
                                          color:
                                              CustomColors().primaryTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "for $daysLeftInMonth days",
                                      style: TextStyle(
                                          color:
                                              CustomColors().primaryTextColor))
                                ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              const SizedBox(
                height: 10,
              ),
              const TransactionTabs(),
              // TabBarView( children: [AllTransactions(), Expense(), Income()])
            ],
          ),
        ),
        floatingActionButton: AddTransactionBtn(),
      ),
    );
  }

  formatAmount(String amount) {
    return NumberFormat.currency(locale: 'hi-IN', decimalDigits: 0, name: "")
        .format(double.parse(amount));
  }

  getPercentile() {
    return double.parse(primaryGroup['currentAmountInPercent']) / 100;
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    context.pushReplacement('/login');
  }
}

class TransactionTabs extends StatelessWidget {
  const TransactionTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const TabBar(
            tabs: [
              Tab(
                text: "All",
              ),
              Tab(text: "Expense"),
              Tab(text: "Income"),
            ],
          ),
          Container(
            // color: Colors.amber,
            height: MediaQuery.of(context).size.height,
            child: const TabBarView(
                children: [AllTransactions(), Expense(), Income()]),
          )
        ],
      ),
    );
  }
}

class TransactionListTile extends StatelessWidget {
  final List transactions;
  const TransactionListTile({super.key, required this.transactions});

  formatAmount(double amount) {
    return NumberFormat.currency(locale: 'hi-IN', decimalDigits: 0, name: "")
        .format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.money),
          ),
          title: Text(
            transactions[index]['categoryName'].toString(),
            style: const TextStyle(fontSize: 14),
          ),
          trailing: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: transactions[index]['transactionType'] == "Expense"
                        ? Colors.red
                        : Colors.green),
                children: [
                  TextSpan(
                    text: transactions[index]['transactionType'] == "Expense"
                        ? "-"
                        : "+",
                  ),
                  TextSpan(
                      text: formatAmount(
                          double.parse(transactions[index]['amount']))),
                ]),
          ),
        );
      },
    );
  }
}

// All Transaction widget

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransactions();
  }

  getTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = json.decode(prefs.getString("userInfo")!);
    var currentDate = DateTime.now();
    var obj = {
      "month": "${currentDate.month}",
      "year": "${currentDate.year}",
      "userId": "${userInfo['id']}",
      "transType": ""
    };

    var response = await TransactionService().getUserTransactions(obj);
    print(response.toString());
    setState(() {
      transactions = response['result'];
    });
  }

  List transactions = [];

  @override
  Widget build(BuildContext context) {
    return TransactionListTile(transactions: transactions);
  }
}

// Expenses Transaction widget

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  List transactions = [];

  getTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = json.decode(prefs.getString("userInfo")!);
    var currentDate = DateTime.now();
    var obj = {
      "month": "${currentDate.month}",
      "year": "${currentDate.year}",
      "userId": "${userInfo['id']}",
      "transType": "Expense"
    };

    var response = await TransactionService().getUserTransactions(obj);
    setState(() {
      transactions = response['result'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return TransactionListTile(transactions: transactions);
  }
}

// Income Transaction widget

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  List transactions = [];

  getTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = json.decode(prefs.getString("userInfo")!);
    var currentDate = DateTime.now();
    var obj = {
      "month": "${currentDate.month}",
      "year": "${currentDate.year}",
      "userId": "${userInfo['id']}",
      "transType": "Income"
    };
    var response = await TransactionService().getUserTransactions(obj);
    setState(() {
      transactions = response['result'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return TransactionListTile(transactions: transactions);
  }
}
