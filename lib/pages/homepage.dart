import 'package:expense_tracker/components/add_transaction_btn.dart';
import 'package:expense_tracker/configs/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
    super.initState();
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
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Home",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            Card(
              color: CustomColors().primaryColor,
              // elevation: 8,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: CustomColors().secondaryColor, width: 3)),
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
                              "Family Budget",
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
                                        text: "${formatAmount(currentAmount)}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: CustomColors().primaryColor,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text:
                                            " left of ${formatAmount(budgetTotal)}",
                                        style: TextStyle(
                                            color: CustomColors()
                                                .primaryTextColor))
                                  ],
                                  style: TextStyle(
                                      // fontSize: 18,
                                      color: CustomColors().secondaryColor)),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LinearPercentIndicator(
                      percent: 0.5,
                      lineHeight: 18.0,
                      barRadius: const Radius.circular(3),
                      center: const Text(
                        "50.0%",
                        style: TextStyle(fontSize: 12.0),
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
                                  color: CustomColors().primaryTextColor)),
                          TextSpan(
                              text:
                                  "${(currentAmount / daysLeftInMonth).toStringAsFixed(1)}/day ",
                              style: TextStyle(
                                  color: CustomColors().primaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "for $daysLeftInMonth days",
                              style: TextStyle(
                                  color: CustomColors().primaryTextColor))
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TransactionTabs(),
            // TabBarView( children: [AllTransactions(), Expense(), Income()])
          ],
        ),
      ),
      floatingActionButton:  AddTransactionBtn(),
    );
  }

  formatAmount(double amount) {
    return NumberFormat.currency(locale: 'hi-IN', decimalDigits: 0, name: "")
        .format(amount);
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
            transactions[index]['transactionName'].toString(),
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
                          transactions[index]['transactionAmount'])),
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
      "transactionType": "Expense",
      "transactionAmount": 1000,
      "transactionName": "Entertainment"
    },
  ];

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
  List transactions = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return TransactionListTile(transactions: transactions);
  }
}
