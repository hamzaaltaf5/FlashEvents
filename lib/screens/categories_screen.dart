import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
          ),
          child: GridView.count(
            primary: false,
            padding: EdgeInsets.all(20.0),
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 2,
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1497211419994-14ae40a3c7a3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text('ADVENTURE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white), ),
                  ),
                ),
              ),

              Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1626238015170-608e4a4c6ff8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Zm9vZCUyMGJsdXIlMjBpbWFnZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=1000&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text('FOOD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
                  ),
                ),
              ),


            ],
          ),
        )
    );
  }
}
