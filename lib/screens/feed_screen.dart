import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: RichText(
          text: TextSpan(
              text: 'Flash',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: 'Events.',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ))
              ]),
        ),
        centerTitle: false,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.messenger_outline,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => Column(
              children: [

                PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
                SizedBox(height: 5.0,),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*
Appbar

 */

/*
Feed content
StreamBuilder(
        stream: FirebaseFirestore.instance.doc('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => PostCard(),
          );
        }
        ),
 */
