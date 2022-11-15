import 'package:flutter/material.dart';
import 'package:joyful/add_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = [
    {
      'name': 'Pergi ke pasar',
      'isChecked': false,
    },
    {
      'name': 'Merapikan baju Emak',
      'isChecked': true,
    },
    {
      'name': 'Cuci piring aja',
      'isChecked': false,
    },
  ];
  var sortedData = [];

  @override
  Widget build(BuildContext context) {
    sortedData = sortTaskList(data);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JOYFUL'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: sortedData.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.amber[300]!.withAlpha(30),
                    onTap: () {},
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: sortedData[index]['isChecked'] as bool,
                            onChanged: (bool? value) {
                              setState(() {
                                sortedData[index]['isChecked'] = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              '${sortedData[index]['name']}',
                              style: TextStyle(decoration: sortedData[index]['isChecked'] == true ? TextDecoration.lineThrough : TextDecoration.none),
                            ),
                          ),
                          const Icon(Icons.close, color: Colors.red),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            ListTile(
              title: Text('Dark Mode'),
              trailing: DarkModeSwitch(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddPage())
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

List sortTaskList(dynamic data) {
  var isCheckedFalse = [];
  var isCheckedTrue = [];

  for (var datum in data) {
    datum['isChecked'] == true ? isCheckedTrue.add(datum) : isCheckedFalse.add(datum);
  }

  return isCheckedFalse + isCheckedTrue;
}

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
        });
      },
    );
  }
}