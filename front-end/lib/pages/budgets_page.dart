import 'dart:convert';

import 'package:expense_tracker/components/add_transaction_btn.dart';
import 'package:expense_tracker/configs/CustomColors.dart';
import 'package:expense_tracker/services/group_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  List groups = [];
  int daysLeftInMonth = 0;
  @override
  void initState() {
    // TODO: implement initState
    setDaysLeftInMonth();
    getGroups();
    super.initState();
  }

  getGroups() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = jsonDecode(prefs.getString('userInfo')!);
    print(userInfo);
    var response = await GroupService()
        .getAllGroups(userInfo['id'].toString(), userInfo['email'].toString());
    setState(() {
      groups = response['result'];
    });
  }

  setDaysLeftInMonth() {
    DateTime now = DateTime.now();
    int totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;
    setState(() {
      daysLeftInMonth = totalDaysInMonth - now.day;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Groups & Budgets",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: groups.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BudgetCard(
                    groupDetails: groups[index],
                    setAsPrimary: () {
                      setAsPrimary(context, groups[index]);
                    },
                  );
                },
              ),
              //const TransactionTabs(),
              // TabBarView( children: [AllTransactions(), Expense(), Income()])
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: CustomColors().secondaryColor, width: 3),
                  ),
                  child: IconButton(
                      onPressed: () {
                        context.go("/addgroup");
                      },
                      icon: Icon(Icons.add)),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: AddTransactionBtn(),
      ),
    );
  }

  setAsPrimary(context, groupDetails) async {
    var response = await GroupService()
        .setAsPrimary(groupDetails['id'], groupDetails['userId']);
    if (response["statusCode"] == 200) {
      getGroups();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Set as primary"),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong"),
        backgroundColor: Colors.red,
      ));
    }
  }
}

class BudgetCard extends StatefulWidget {
  var groupDetails;
  // typedef VoidCallback = void Function();
  final VoidCallback setAsPrimary;
  BudgetCard(
      {super.key, required this.groupDetails, required this.setAsPrimary});

  @override
  State<BudgetCard> createState() => _BudgetCardState();
}

class _BudgetCardState extends State<BudgetCard> {
  get currentAmount => 10000;

  int daysLeftInMonth = 0;

  get budgetTotal => 20000;

  @override
  initState() {
    super.initState();
    setDaysLeftInMonth();
  }

  setDaysLeftInMonth() {
    DateTime now = DateTime.now();
    int totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;
    setState(() {
      daysLeftInMonth = totalDaysInMonth - now.day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors().primaryColor,
      // elevation: 8,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: CustomColors().secondaryColor, width: 3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: widget.groupDetails['isPrimary'] == "Y"
                  ? Colors.amber
                  : CustomColors().secondaryColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.groupDetails['groupName']}",
                          style: TextStyle(
                              color: CustomColors().primaryTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "${formatAmount(widget.groupDetails['currentAmount'])}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: CustomColors().primaryColor,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        " left of ${formatAmount(widget.groupDetails['groupBudget'])}",
                                    style: TextStyle(
                                        color: CustomColors().primaryTextColor))
                              ],
                              style: TextStyle(
                                  // fontSize: 18,
                                  color: CustomColors().secondaryColor)),
                        )
                      ],
                    ),
                    widget.groupDetails['isPrimary'] != "Y"
                        ? OutlinedButton(
                            // style: ButtonStyle(),
                            onPressed: () {
                              widget.setAsPrimary();
                            },
                            child: const Text(
                              "Set as primary",
                              style: TextStyle(color: Colors.white),
                            ))
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearPercentIndicator(
              percent:
                  getPercentile(widget.groupDetails['currentAmountInPercent']),
              lineHeight: 18.0,
              barRadius: const Radius.circular(3),
              center: Text(
                "${double.parse(widget.groupDetails['currentAmountInPercent']).toStringAsFixed(1) * 1}%",
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
                      style: TextStyle(color: CustomColors().primaryTextColor)),
                  TextSpan(
                      text:
                          "${(double.parse(widget.groupDetails['currentAmount']) / daysLeftInMonth).toStringAsFixed(1)}/day ",
                      style: TextStyle(
                          color: CustomColors().primaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "for $daysLeftInMonth days",
                      style: TextStyle(color: CustomColors().primaryTextColor))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  getPercentile(amount) {
    return double.parse(widget.groupDetails['currentAmountInPercent']) / 100;
  }

  formatAmount(String amount) {
    return NumberFormat.currency(locale: 'hi-IN', decimalDigits: 0, name: "")
        .format(double.parse(amount));
  }
}
