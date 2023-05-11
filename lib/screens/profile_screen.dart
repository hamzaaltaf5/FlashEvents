import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../resources/auth_methods.dart';
import '../resources/firestore_methods.dart';
import '../screens/add_post_screen.dart';
import '../screens/login_screen.dart';
import '../utils/utils.dart';
import '../widgets/follow_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({
    required this.uid,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  Uint8List? _file;
  final phoneNumber = '03105617783';



  selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a Post'),
            children: [
              Divider(
                height: 10,
                thickness: 2.0,
                color: Colors.black,
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20.0),
                child: Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera, 50);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20.0),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery, 100);
                  setState(() {
                    _file = file;
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //get post LENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      //postLen = userSnap.data()!['posts'].length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showOption(BuildContext context){
    final toEmail = userData['email'];
    showDialog(context: context, builder: (_){
      return SimpleDialog(
        title: Text('Choose Your Option'),
        children: [

          Divider(
            color: Colors.black,
            thickness: 2.0,
          ),

          SimpleDialogOption(
            child: Text('Call ${userData['username']}'),
            onPressed: () async {

              final Uri url = Uri.parse('tel: ${userData['linenumber']}');
              //final url = 'tel: $phoneNumber';

              if (await canLaunchUrl(url)){
                await launchUrl(url);
              }
            },
          ),

          SimpleDialogOption(
            child: Text('Message ${userData['username']}'),
            onPressed: () async {
              final Uri url = Uri.parse('sms: ${userData['linenumber']}');

              if(await canLaunchUrl(url)){
                await launchUrl(url);
              }
            },
          ),

          SimpleDialogOption(
            child: Text('Email'),
            onPressed: () async {
              final Uri url = Uri.parse('mailto:$toEmail');

              if( await canLaunchUrl(url) ){
                await launchUrl(url);
              }
            },
          )

        ],
      );
    });
  }



  @override
  Widget build(BuildContext context) {

    void enlarge(){
      showDialog(
          context: context,
          builder: (context){
            return Container(
              child: SimpleDialog(
                title: ListTile(
                  title: ListTile(
                    title: Text(userData['username']),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userData['photoUrl']),
                    ),
                    trailing: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.more_vert),
                    ),
                  ),
                ),
                children: [


                  Container(
                    height: 300,
                    child: Image(
                      image: NetworkImage(userData['postUrl']),
                    ),
                  ),

                ],
              ),
            );
          }
      );
    }


    return isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(userData['username']),
        centerTitle: false,
        actions: [
          // IconButton(
          //   onPressed: () => selectImage(context),
          //   icon: Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(userData['photoUrl']),
                      radius: 100.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //
                          //   ],
                          // ),
                          buildStatColumn(postLen, 'Post'),
                          buildStatColumn(followers, 'Followers'),
                          buildStatColumn(following, 'Following'),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    userData['username'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 1.0),
                  child: Text(
                    userData['bio'],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                        ? CustomButton(
                      text: 'SignOut',
                      backgroundColor: Colors.white,
                      borderColor: Colors.grey,
                      function: () async {
                        await AuthMethods().signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    )
                        : isFollowing
                        ? CustomButton(
                      text: 'Unfollow',
                      backgroundColor: Colors.white,
                      borderColor: Colors.grey,
                      function: () async {
                        await FirestoreMethods().followUser(
                            FirebaseAuth
                                .instance.currentUser!.uid,
                            userData['uid']);
                        setState(() {
                          isFollowing = false;
                          followers--;
                        });
                      },
                    )
                        : CustomButton(
                      text: 'Follow',
                      backgroundColor: Colors.teal,
                      borderColor: Colors.grey,
                      function: () async {
                        await FirestoreMethods().followUser(
                            FirebaseAuth
                                .instance.currentUser!.uid,
                            userData['uid']);
                        setState(() {
                          isFollowing = true;
                          followers++;
                        });
                      },
                      textColor: Colors.white,
                    ),
                    FirebaseAuth.instance.currentUser!.uid == widget.uid ?
                    Container():
                    CustomButton(
                      text: 'Contact Now',
                      backgroundColor: Colors.teal,
                      borderColor: Colors.grey,
                      function: () {
                        _showOption(context);
                      },
                      textColor: Colors.white,
                    ),
                    // FirebaseAuth.instance.currentUser!.uid == widget.uid
                    //     ? Container()
                    //     : TextButton(
                    //         onPressed: () {},
                    //         child: Card(
                    //           child: Container(
                    //             height: 27,
                    //             width: 100,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(color: Colors.grey),
                    //               color: Colors.teal,
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 'Book Now',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: widget.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  DocumentSnapshot snap =
                  (snapshot.data! as dynamic).docs[index];

                  return GestureDetector(
                    onTap: () async {
                      return showDialog(
                          context: context,
                          builder: (context){
                            return Container(
                              child: SimpleDialog(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    CircleAvatar(
                                      backgroundImage: NetworkImage(userData['photoUrl']),
                                    ),

                                    SizedBox(width: 5.0,),

                                    Text(userData['username']),


                                  ],
                                ),
                                children: [

                                  Container(
                                    height: 350,
                                    child: Image(
                                      image: NetworkImage(snap['postUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Row(
                                    children: [

                                      IconButton(
                                        onPressed: (){
                                          print('like');
                                        },
                                        icon: Icon(Icons.favorite),
                                        iconSize: 25.0,
                                      ),

                                      IconButton(
                                        onPressed: (){
                                          print('comment');
                                        },
                                        icon: Icon(Icons.comment),
                                        iconSize: 25.0,
                                      ),

                                      IconButton(
                                        onPressed: (){
                                          print( 'Share' );
                                        },
                                        icon: Icon( Icons.share ),
                                        iconSize: 25.0,
                                      ),

                                    ],
                                  ),

                                  Divider(
                                    color: Colors.black,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [

                                        Text(snap['title'], style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),

                                        SizedBox(height: 10.0,),

                                        Text(snap['description'],),

                                      ],
                                    ),
                                  )

                                ],
                              ),
                            );
                          }
                      );
                    },
                    child: Container(
                      child: Image(
                        image: NetworkImage(
                          snap['postUrl'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}

/*
IconButton to navigate to AddPostScreen()
IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPostScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
 */

/*
Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                            radius: 55.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(postLen, 'Post'),
                                    buildStatColumn(followers, 'Followers'),
                                    buildStatColumn(following, 'Following'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FirebaseAuth.instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            text: 'Edit Profile',
                                            backgroundColor: Colors.white,
                                            borderColor: Colors.grey,
                                            function: () {},
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                borderColor: Colors.grey,
                                                function: () {},
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: Colors.teal,
                                                borderColor: Colors.grey,
                                                function: () {},
                                                textColor: Colors.white,
                                              )
                                  ],
                                ),
                                FirebaseAuth.instance.currentUser!.uid ==
                                        widget.uid
                                    ? Container()
                                    : TextButton(
                                        onPressed: () {},
                                        child: Card(
                                          child: Container(
                                            height: 27,
                                            width: 180,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                color: Colors.teal),
                                            child: Center(
                                              child: Text(
                                                'Book Now',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
 */
