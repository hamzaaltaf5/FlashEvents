import '../providers/user_provider.dart';
import '../utils/colors.dart';
import '../widgets/like_animation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../resources/firestore_methods.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({Key? key, this.snap}) : super(key: key);

  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      height: 350,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.snap['postUrl']),
            fit: BoxFit.cover,
          )),
      child: Stack(
        children: [
          // GestureDetector(
          //   onDoubleTap: (){
          //     setState(() {
          //       isLikeAnimating = true;
          //     });
          //   },
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //
          //       LikeAnimations(
          //         child: Icon(Icons.favorite, color: Colors.teal, size: 100.0,),
          //         isAnimating: isLikeAnimating,
          //         duration: Duration(
          //           milliseconds: 400,
          //         ),
          //         onEnd: (){
          //           isLikeAnimating = false;
          //         },
          //       )
          //
          //     ],
          //   ),
          // ),

          //Containing Profile image, username, and more button
          Visibility(
            child: Positioned(
              top: 15,
              left: 15,
              child: Row(
                children: [
                  //profile image and name
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.snap['profImage']),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.snap['username'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 155.0,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                onTap: () async {
                                  FirestoreMethods().deletePost(widget.snap['postId']);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  child: Text(e),
                                ),
                              ),
                            )
                                .toList(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Visibility(
            child: Positioned(
              bottom: 0,
              child: Container(
                  height: 125,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xFF000000), Color(0x000000)])),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['title'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times new roman'),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            LikeAnimations(
                              //isAnimating: widget.snap['like'].contains(user.uid),
                              smallLike: true,
                              child: IconButton(
                                  onPressed: () async {
                                    await FirestoreMethods().likePost(
                                        widget.snap['postId'],
                                        user.uid!,
                                        widget.snap['likes']);
                                  },
                                  icon: widget.snap['likes'].contains(user.uid)
                                      ? const Icon(
                                    Icons.favorite,
                                    color: Colors.amber,
                                    size: 25.0,
                                  )
                                      : const Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.white,
                                    size: 25.0,
                                  )),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text('Comments',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      children: [
                                        Divider(
                                          color: Colors.teal,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text('View all 200 comments'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.comment),
                              iconSize: 25.0,
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                print('Share');
                              },
                              icon: Icon(Icons.send),
                              iconSize: 25.0,
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        title: Text(
                                          widget.snap['title'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        children: [
                                          Divider(
                                            color: Colors.teal,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                                widget.snap['description']),
                                          ),
                                          Divider(
                                            color: Colors.teal,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                                '${widget.snap['likes'].length} likes'),
                                          ),
                                          Divider(
                                            color: Colors.teal,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child:
                                            Text(DateFormat.yMMMd().format(
                                              widget.snap['datePublished']
                                                  .toDate(),
                                            )),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(Icons.details),
                              iconSize: 25.0,
                              color: Colors.white,
                            ),
                            // SizedBox(
                            //   width: 50,
                            // ),
                            // ElevatedButton(
                            //   onPressed: () => print('Book from homePage'),
                            //   child: Text('Book Now'),
                            // )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

//The tutorial code
/*
Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            //Header Section
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16.0,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1670264736611-7d9866f51c19?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=385&q=80'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.more_vert)),
                ],
              ),
              //Image Section
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height*0.35,
              width: double.infinity,
              child: Image.network('https://images.unsplash.com/photo-1669798158874-9c05aa89d71b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=60', fit: BoxFit.cover,),
            ),

          ],
        ),
      ),
    );
 */
