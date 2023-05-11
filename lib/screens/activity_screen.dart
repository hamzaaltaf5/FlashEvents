import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: Center(
        child: ListView(
          children: [

            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1627087820883-7a102b79179a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
              ),
              title: Text('Hussain liked your post'),
              trailing: Icon(Icons.favorite, color: Colors.amber,),

            ),

            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1625417026759-69162d7ded55?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80'),
              ),
              title: Text('Usama liked your post'),
              trailing: Icon(Icons.favorite, color: Colors.amber,),

            ),

            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1608549036505-ead5b1de5417?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80'),
              ),
              title: Text('Misbah liked your post'),
              trailing: Icon(Icons.favorite, color: Colors.amber,),

            ),

            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1614289371518-722f2615943d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
              ),
              title: Text('Babar liked your post'),
              trailing: Icon(Icons.favorite, color: Colors.amber,),

            ),

          ],
        ),
      ),
    );
  }
}
