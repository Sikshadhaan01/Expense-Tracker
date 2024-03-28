import 'package:expense_tracker/components/add_transaction_btn.dart';
import 'package:expense_tracker/configs/CustomColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  get currentAmount => 10000;
  
  get daysLeftInMonth => 0;
  
  get budgetTotal => 20000;

  
  @override
  // void initState() {
  //   // TODO: implement initState
  //   setDaysLeftInMonth();
  //   super.initState();
  // }

  // setDaysLeftInMonth() {
  //   DateTime now = DateTime.now();
  //   int totalDaysInMonth = DateTime(now.year, now.month + 1, 0).day;
  //   setState(() {
  //     daysLeftInMonth = totalDaysInMonth - now.day;
  //   });
  // }
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Budget",
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
             //const TransactionTabs(),
            // TabBarView( children: [AllTransactions(), Expense(), Income()]) 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: IconButton(onPressed: (){
                  context.go("/addgroup");
                }, icon:Icon(Icons.add)),
                height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration( 
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: CustomColors().secondaryColor, width: 3),),),
            )
          ],
        ),
        
      ),
      floatingActionButton: AddTransactionBtn(),
      
    );
  }
  
   formatAmount(double amount) {
    return NumberFormat.currency(locale: 'hi-IN', decimalDigits: 0, name: "")
        .format(amount);
  }
}
