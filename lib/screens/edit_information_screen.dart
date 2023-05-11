import '../widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class EditInformationScreen extends StatefulWidget {
  const EditInformationScreen({Key? key}) : super(key: key);

  @override
  _EditInformationScreenState createState() => _EditInformationScreenState();
}

class _EditInformationScreenState extends State<EditInformationScreen> {
  final TextEditingController _bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [

            Stack(
              children: [

                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1665686306265-c52ee9054479?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                ),

                SizedBox(height: 20.0,),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Bio',
                  ),
                  controller: _bioController,

                )

              ],
            )

          ],
        ),
      ),
    );
  }
}
