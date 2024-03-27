import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetandmemberPage extends StatelessWidget {
  const BudgetandmemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => context.go("/budgetspage"),
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: "Add Group",
              ),
              Tab(
                text: "Members list",
              )
            ]),
          ),
          body: const TabBarView(
            children: [
              AddMember(),
              MembersList()

              // Icon(Icons.directions_transit),
            ],
          ),
        ));
  }
}

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
   List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Group Name"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.currency_rupee),
                        hintText: "Budget"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(controller: SearchController(),
              decoration: InputDecoration(
                  labelText: "Add member",
                  suffixIcon:
                      IconButton(onPressed: () {
                        searchTerms;
                      }, icon: const Icon(Icons.search))),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Icon(Icons.check))
        ],
      ),
    );
  }
}

class MembersList extends StatefulWidget {
  const MembersList({super.key});

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  @override
  Widget build(BuildContext context) {
    List memberslist = [
      "jineesh",
      "parjith",
      "saran",
    ];
    return Scaffold(
      body: ListView.builder(
        itemCount: memberslist.length,
        itemBuilder: (context, index) {
          return Container(
            height: 55,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  memberslist[index],
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
