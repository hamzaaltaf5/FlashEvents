import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/categories_screen.dart';
import '../screens/image_classification_screen.dart';
import '../screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search for a user',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.white,
                )),
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.image_search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ImageClassificationScreen()));
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.category),
          //   color: Colors.black,
          //   onPressed: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
          //   },
          // )
        ],
      ),
      body: isShowUsers
          ? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where(
          'username',
          isLessThanOrEqualTo: searchController.text,
        )
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                        uid: (snapshot.data! as dynamic).docs[index]
                        ['uid']),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]
                        ['photoUrl']),
                  ),
                  title: Text((snapshot.data! as dynamic).docs[index]
                  ['username']),
                ),
              );
            },
          );
        },
      )
          : FutureBuilder(
        future: FirebaseFirestore.instance.collection('posts').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: EdgeInsets.all(5.0),
            child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              //physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => Image.network(
                (snapshot.data! as dynamic).docs[index]['postUrl'],
                fit: BoxFit.cover,
              ),
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(1, index.isEven ? 2 : 1),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          );
        },
      ),
    );
  }
}
