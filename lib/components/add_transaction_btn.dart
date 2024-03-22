import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactionBtn extends StatelessWidget {
  const AddTransactionBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small( backgroundColor: Color(0xFF1e3557),
      onPressed: () {
        openModelSheet(context);
      },
      child: Icon(Icons.add,color: Colors.white,),
    );
  }
  openModelSheet(context){
    showModalBottomSheet(context: context, builder:(context) {
      return Container(child: Text("sheet",),height: 300,width:double.infinity,);
    },);
  }
}
