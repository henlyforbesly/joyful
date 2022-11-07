import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JOYFUL'),
      ),
      body: Column(
        children: [
           Dismissible(
                direction: DismissDirection.endToStart,
                key: const Key('1'),
                onDismissed: (direction) {
                  // Removes that item the list on swipwe
                  setState(() {
                  });
                  // Shows the information on Snackbar
                  //Scaffold.of(context)
                      //.showSnackBar(SnackBar(content: Text("item telah dihapus")));
                },
                background: Container(color: Colors.red),
                secondaryBackground: Container(color: Colors.green) ,
                child: ListTile(title: Text('tugas 1')),
              )
        ],
      ) ,

    );
  }
}