import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

DateTime now = DateTime.now();

TextEditingController _date = TextEditingController();
TextEditingController _time = TextEditingController();



  @override
void initState() {
    _time.text  = "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body:Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Tugas',
              icon: Icon(Icons.assessment),
              focusedBorder: OutlineInputBorder(),
            ),
            maxLines: 1,
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _date,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today_rounded),
                labelText: "Tanggal"
              ),
              onTap: () async {
                DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate:DateTime.now() ,
                  firstDate: DateTime(2000),
                   lastDate: DateTime(3000));

                   if(pickeddate != null){
                    setState(() {
                      _date.text = DateFormat('yyyy.MM.dd').format(pickeddate);
                    });
                   }
              },
            ),
            ),
            SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _time,
              decoration: const InputDecoration(
                icon: Icon(Icons.timer),
                labelText: "waktu"
              ),
              onTap: () async {
                TimeOfDay? pickedtime= await showTimePicker(context: context, initialTime: TimeOfDay.now());

                   if(pickedtime != null){
                    setState(() {
                      print(pickedtime.format(context));
                      DateTime parsedTime = DateFormat.jm().parse(pickedtime.format(context).toString());
                       String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime);
                         setState(() {
                       _time.text = formattedTime; //set the value of text field.
                      });
                    });
                   }else{
                    print("time is not selected");
                   }
              },
            ),
            ),
        SizedBox(height: 80,),
         TextField(
            decoration: InputDecoration(
              labelText: 'Deskripsi',
              focusedBorder: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          SizedBox(height:100),
          Container(
            height: 60,
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 239, 198, 63)
                ),
              onPressed: (){},
            child: Text(
              "ADD",style: TextStyle(
              color: Color(0xFF000000)
            )
            ),
            ),
          )
      ],
    ),
  ),


 );

}




}