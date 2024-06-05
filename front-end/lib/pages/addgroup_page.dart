import 'dart:convert';

import 'package:expense_tracker/services/group_service.dart';
import 'package:expense_tracker/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

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
              onPressed: () => context.go("/"),
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

enum Options {
  blue('Yes'),
  pink('No');

  const Options(this.label);
  final String label;
  // final Color color;
}

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupBudgetController = TextEditingController();
  bool isPrimary = false;

  List _selectedMembers = [];
  static List allMembers = [];
  List<MultiSelectItem<Object?>> _items = allMembers
      .map((member) => MultiSelectItem(member, member["userName"]))
      .toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllMembers();
  }

  getAllMembers() async {
    var response = await UserService().getAllUsers();
    setState(() {
      allMembers = response['result'][0];
      _items = allMembers
          .map((member) => MultiSelectItem(member, member["userName"]))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: groupNameController,
              decoration: const InputDecoration(labelText: "Group Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: groupBudgetController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.currency_rupee),
                        hintText: "Budget"),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text(
                      "Primary",
                      style: TextStyle(fontSize: 12),
                    ),
                    Checkbox(
                      onChanged: (value) {
                        setState(() {
                          isPrimary = value! ? value : false;
                        });
                      },
                      value: isPrimary,
                    ),
                  ],
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MultiSelectBottomSheetField(
              buttonText: const Text("Add Members"),
              buttonIcon: const Icon(Icons.people_outlined),
              title: const Text("Select Members"),
              initialChildSize: 0.8,
              listType: MultiSelectListType.LIST,
              searchable: true,
              items: _items,
              // initialValue: [],
              onConfirm: (values) {
                _selectedMembers = values;
              },
              maxChildSize: 0.8,
              chipDisplay: MultiSelectChipDisplay(
                onTap: (value) {
                  setState(() {
                    _selectedMembers.remove(value);
                  });
                },
              ),
            ),
          ),
          isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    saveGroup();
                  },
                  child: const Icon(Icons.check))
        ],
      ),
    );
  }

  bool isLoading = false;
  saveGroup() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = jsonDecode(prefs.getString('userInfo')!);
    var obj = {
      "groupName": groupNameController.text,
      "groupBudget": groupBudgetController.text,
      "members": _selectedMembers,
      "currentAmount": groupBudgetController.text,
      "isPrimary": isPrimary ? "Y" : "N",
      "userId": userInfo['id']
    };
    var response = await GroupService().saveGroup(obj);
    if (response["statusCode"] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Group Created"),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong"),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {
      isLoading = false;
    });
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

class SearchField extends SearchDelegate {
  List<String> listof = ['jineesh', 'saran', 'prajith'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in listof) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in listof) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
