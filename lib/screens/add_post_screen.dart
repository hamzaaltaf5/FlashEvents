import '../resources/firestore_methods.dart';
import '../utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  bool _isLoading = false;

  void postImage(
      String uid,
      String username,
      String profImage,
      ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _titleController.text,
          _file!,
          uid,
          username,
          profImage);

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, 'Posted!');
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, res);
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60.0,
            ),

            Text(
              'Create Post',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),

            SizedBox(
              height: 200.0,
            ),

            //First Row

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uint8List file =
                        await pickImage(ImageSource.gallery, 50);
                        setState(() {
                          _file = file;
                        });
                      },
                      child: Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        child: Center(
                          child: Icon(Icons.image_outlined),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('GALLERY'),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uint8List file =
                        await pickImage(ImageSource.camera, 50);
                        setState(() {
                          _file = file;
                        });
                      },
                      child: Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.amber),
                        child: Center(
                          child: Icon(Icons.camera_alt),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('CAMERA'),
                  ],
                ),
                // Column(
                //   children: [
                //     GestureDetector(
                //       child: Container(
                //         height: 70.0,
                //         width: 70.0,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             border: Border.all(
                //               color: Colors.amber,
                //             )),
                //         child: Center(
                //           child: Icon(Icons.link),
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10.0,
                //     ),
                //     Text('LINK'),
                //   ],
                // ),
              ],
            ),

            // //Second Row
            // SizedBox(
            //   height: 30.0,
            // ),
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Column(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             height: 70.0,
            //             width: 70.0,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: Colors.amber,
            //                 )),
            //             child: Center(
            //               child: Icon(Icons.music_note),
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10.0,
            //         ),
            //         Text('MUSIC'),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             height: 70.0,
            //             width: 70.0,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: Colors.amber,
            //                 )),
            //             child: Center(
            //               child: Icon(Icons.movie_outlined),
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10.0,
            //         ),
            //         Text('MOVIE'),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             height: 70.0,
            //             width: 70.0,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: Colors.amber,
            //                 )),
            //             child: Center(
            //               child: Icon(Icons.book_outlined),
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10.0,
            //         ),
            //         Text('BOOK'),
            //       ],
            //     ),
            //   ],
            // ),
            //
            // //Third Row
            // SizedBox(
            //   height: 30.0,
            // ),
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Column(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             height: 70.0,
            //             width: 70.0,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: Colors.amber,
            //                 )),
            //             child: Center(
            //               child: Icon(Icons.settings_applications),
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10.0,
            //         ),
            //         Text('APP'),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             height: 70.0,
            //             width: 70.0,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: Colors.amber,
            //                 )),
            //             child: Center(
            //               child: Icon(Icons.games),
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10.0,
            //         ),
            //         Text('GAME'),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         GestureDetector(
            //           child: Container(
            //             height: 70.0,
            //             width: 70.0,
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: Colors.amber,
            //                 )),
            //             child: Center(
            //               child: Icon(Icons.place),
            //             ),
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10.0,
            //         ),
            //         Text('PLACE'),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        title: Text('Add Post'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () =>
                postImage(user.uid!, user.username!, user.photoUrl!),
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _isLoading
                ? const LinearProgressIndicator(color: Colors.amber,)
                : Padding(
              padding: EdgeInsets.only(top: 0.0),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  child: Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_file!),
                        )),
                  ),
                )),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(user.photoUrl!),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter a title',
                    ),
                    maxLength: 30,
                  ),
                ),
              ],
            ),
            Divider(),
            Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write a Caption',
                    contentPadding: EdgeInsets.all(5.0),
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
  }
}

// // import 'dart:convert';
// // import 'dart:io';
// //
// // import 'package:flashevents_final/resources/firestore_methods.dart';
// // import 'package:flashevents_final/screens/add_post_details.dart';
// // import 'package:flashevents_final/screens/feed_screen.dart';
// // import 'package:flashevents_final/utils/utils.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:provider/provider.dart';
// // import '../models/user.dart';
// // import '../providers/user_provider.dart';
// // import 'package:flutter_storage_path/flutter_storage_path.dart';
// // import '../utils/utils.dart';
// //
// // class AddPostScreen extends StatefulWidget {
// //   const AddPostScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   _AddPostScreenState createState() => _AddPostScreenState();
// // }
// //
// // class _AddPostScreenState extends State<AddPostScreen> {
// //   Uint8List? _file;
// //   final TextEditingController _descriptionController = TextEditingController();
// //   final TextEditingController _titleController = TextEditingController();
// //   bool _isloading = false;
// //   String? image;
// //
// //
// //
// //   void postImage(
// //     String uid,
// //     String username,
// //     String profImage,
// //   ) async {
// //     setState(() {
// //       _isloading = true;
// //     });
// //     try {
// //       String res = await FirestoreMethods().uploadPost(
// //         _titleController.text,
// //         _descriptionController.text,
// //         _file!,
// //         uid,
// //         username,
// //         profImage,
// //       );
// //
// //       if (res == 'success') {
// //         setState(() {
// //           _isloading = false;
// //         });
// //         showSnackBar(context, 'Posted');
// //         clearImage();
// //       } else {
// //         setState(() {
// //           _isloading = false;
// //         });
// //         showSnackBar(context, res);
// //       }
// //     } catch (err) {
// //       showSnackBar(context, err.toString());
// //     }
// //   }
// //
// //   selectImage(BuildContext context) async {
// //     return showDialog(
// //         context: context,
// //         builder: (context) {
// //           return SimpleDialog(
// //             title: Text('Create a Post'),
// //             children: [
// //               Divider(
// //                 height: 10,
// //                 thickness: 2.0,
// //                 color: Colors.black,
// //               ),
// //               SimpleDialogOption(
// //                 padding: EdgeInsets.all(20.0),
// //                 child: Text('Take a photo'),
// //                 onPressed: () async {
// //                   Navigator.of(context).pop();
// //                   Uint8List file = await pickImage(ImageSource.camera, 50);
// //                   setState(() {
// //                     _file = file;
// //                   });
// //                 },
// //               ),
// //               SimpleDialogOption(
// //                 padding: EdgeInsets.all(20.0),
// //                 child: Text('Choose from gallery'),
// //                 onPressed: () async {
// //                   Navigator.of(context).pop();
// //                   Uint8List file = await pickImage(ImageSource.gallery, 100);
// //                   setState(() {
// //                     _file = file;
// //                   });
// //                 },
// //               ),
// //             ],
// //           );
// //         });
// //   }
// //
// //   void clearImage() {
// //     setState(() {
// //       _file = null;
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _descriptionController.dispose();
// //     _titleController.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final User user = Provider.of<UserProvider>(context).getUser;
// //
// //     return _file == null? Scaffold(
// //       appBar: AppBar(
// //         title: Text('Add Post'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //
// //             Text('New Post', style: TextStyle(color: Colors.brown, fontSize: 30.0, fontWeight: FontWeight.bold),),
// //
// //         SimpleDialog(
// //           title: Text('Create a Post'),
// //           children: [
// //             Divider(
// //               height: 10,
// //               thickness: 2.0,
// //               color: Colors.black,
// //             ),
// //             SimpleDialogOption(
// //               padding: EdgeInsets.all(20.0),
// //               child: Text('Take a photo'),
// //               onPressed: () async {
// //                 Navigator.of(context).pop();
// //                 Uint8List file = await pickImage(ImageSource.camera, 50);
// //                 setState(() {
// //                   _file = file;
// //                 });
// //               },
// //             ),
// //             SimpleDialogOption(
// //               padding: EdgeInsets.all(20.0),
// //               child: Text('Choose from gallery'),
// //               onPressed: () async {
// //                 Navigator.of(context).pop();
// //                 Uint8List file = await pickImage(ImageSource.gallery, 100);
// //                 setState(() {
// //                   _file = file;
// //                 });
// //               },
// //             ),
// //           ],
// //         ),
// //
// //           ],
// //         ),
// //       ),
// //     ): Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: clearImage,
// //         ),
// //         title: const Text('New Post'),
// //         centerTitle: false,
// //         actions: [
// //           TextButton(
// //             onPressed: () =>
// //                 postImage(user.uid!, user.username!, user.photoUrl!),
// //             child: const Text(
// //               'Post',
// //               style: TextStyle(
// //                 color: Colors.amber,
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 20.0,
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             _isloading
// //                 ? LinearProgressIndicator()
// //                 : Padding(
// //               padding: EdgeInsets.only(top: 0.0),
// //             ),
// //             Divider(),
// //             Padding(
// //               padding: EdgeInsets.all(10.0),
// //               child: SizedBox(
// //                 height: 350,
// //                 width: 300,
// //                 child: AspectRatio(
// //                   aspectRatio: 2.0,
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       image: DecorationImage(
// //                         image: MemoryImage(_file!),
// //                         fit: BoxFit.cover,
// //                         alignment: FractionalOffset.topCenter,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(10.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   CircleAvatar(
// //                     backgroundImage: NetworkImage(user.photoUrl!),
// //                   ),
// //                   const SizedBox(
// //                     width: 10.0,
// //                   ),
// //                   SizedBox(
// //                     width: MediaQuery
// //                         .of(context)
// //                         .size
// //                         .width * 0.50,
// //                     child: TextField(
// //                       controller: _titleController,
// //                       decoration: const InputDecoration(
// //                         hintText: 'Enter a title',
// //                         border: InputBorder.none,
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: MediaQuery
// //                         .of(context)
// //                         .size
// //                         .width * 0.50,
// //                     child: TextField(
// //                       controller: _descriptionController,
// //                       decoration: const InputDecoration(
// //                         hintText: 'Write a caption',
// //                         border: InputBorder.none,
// //                       ),
// //                       maxLines: 8,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const Divider(),
// //           ],
// //         ),
// //       ),
// //     );
// //
// //   }
// //
// //
// // }
//
// /*
//
// getItems() {
//     return _file
//             .map((e) => DropdownMenuItem(
//                   value: e,
//                   child: Text(
//                     e.folder!,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ))
//             .toList() ??
//         [];
//   }
//
// // @override
//   // void initState() {
//   //   super.initState();
//   //   getImagesPath();
//   // }
//
//   // getImagesPath() async {
//   //   var imagePath = await StoragePath.imagesPath;
//   //   var images = jsonDecode(imagePath!) as List;
//   //   _file = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
//   //   if (_file != null && _file.length > 0)
//   //     setState(() {
//   //       _selectedModel = _file[0];
//   //     });
//   // }
//
//
// Failed Code
// appBar: AppBar(
//               title: Text('Select an Image'),
//               actions: [
//
//                 TextButton(
//                   child: Text(
//                     'Next',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPostDetails(image: _file as Uint8List,)));
//                   },
//                 )
//
//               ],
//             ),
//             body: SingleChildScrollView(
//               child: SafeArea(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 10.0),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<FileModel>(
//                               items: getItems(),
//                               onChanged: (FileModel? d) {
//                                 assert(d!.files!.length > 0);
//                                 image = d!.files![0];
//                                 setState(() {
//                                   _selectedModel = d;
//                                 });
//                               },
//                               value: _selectedModel,
//                             ),
//                           ),
//                         ),
//
//                         ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStatePropertyAll<Color>(Colors.amber.shade700),
//                           ),
//                           child: Text('Take a Photo'),
//                           onPressed: () async {
//                             Navigator.of(context).pop();
//                             List<FileModel> file = await pickImage(ImageSource.camera, 50);
//                             setState(() {
//                               _file = file;
//                             });
//                           },
//                           // onPressed: () async {
//                           //   Navigator.of(context).pop();
//                           //   Uint8List file = await pickImage(ImageSource.camera, 50);
//                           //   setState(() {
//                           //     _file = file;
//                           //   });
//                           // },
//                         )
//                       ],
//                     ),
//                     Divider(),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.45,
//                       child: image != null
//                           ? Image.file(
//                               File(image!),
//                               height: MediaQuery.of(context).size.height * 0.45,
//                               width: MediaQuery.of(context).size.width,
//                             )
//                           : Center(child: Text('Select an Image'),),
//                     ),
//                     Divider(),
//                     _selectedModel == null && _selectedModel.files!.length < 1
//                         ? Container()
//                         : Container(
//                             height: MediaQuery.of(context).size.height * 0.38,
//                             child: GridView.builder(
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 4,
//                                 crossAxisSpacing: 4,
//                                 mainAxisSpacing: 4,
//                               ),
//                               itemBuilder: (_, i) {
//                                 var file = _selectedModel.files![i];
//                                 return GestureDetector(
//                                   child: Image.file(
//                                     File(file),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   onTap: () {
//                                     setState(() {
//                                       image = file;
//                                     });
//                                   },
//                                 );
//                               },
//                               itemCount: _selectedModel.files!.length,
//                             ),
//                           )
//                   ],
//                 ),
//               ),
//             ),
//     );
//  */
//
// /*
// Back-up tried and tested
// Center(
//               child: Card(
//                 color: Colors.teal,
//                 child: TextButton(
//                   child: Text(
//                     'Add a New Post',
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       color: Colors.amber,
//                     ),
//                   ),
//                   onPressed: () => selectImage(context),
//                 ),
//               )
//               // child: IconButton(
//               //   icon: Icon(Icons.upload),
//               //   onPressed: () => _selectImage(context),
//               // ),
//             ),
//  */
//
// /*
// Tried and tested
// Text(
//                     'Add a New Post',
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       color: Colors.amber,
//                     ),
//                   ),
//                   onPressed: () => _selectImage(context),
//                 ),
//  */
//
// /*
// Post area
// Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(user.photoUrl!),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width * 0.50,
//                         child: TextField(
//                           controller: _descriptionController,
//                           decoration: InputDecoration(
//                             hintText: 'Write a caption',
//                             border: InputBorder.none,
//                           ),
//                           maxLines: 8,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 45,
//                         width: 45,
//                         child: AspectRatio(
//                           aspectRatio: 2.0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                               image: MemoryImage(_file!),
//                               fit: BoxFit.cover,
//                               alignment: FractionalOffset.topCenter,
//                             )),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//  */
//
// /*
//
// Main body
// Column(
//                 children: [
//                   _isloading? LinearProgressIndicator(): Padding(padding: EdgeInsets.only(top: 0.0),),
//                   Divider(),
//                   Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: NetworkImage(user.photoUrl!),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.50,
//                           child: TextField(
//                             controller: _descriptionController,
//                             decoration: InputDecoration(
//                               hintText: 'Write a caption',
//                               border: InputBorder.none,
//                             ),
//                             maxLines: 8,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 45,
//                           width: 45,
//                           child: AspectRatio(
//                               aspectRatio: 2.0,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: MemoryImage(_file!),
//                                       fit: BoxFit.cover,
//                                       alignment: FractionalOffset.topCenter,
//                                     )),
//                               )),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(),
//                 ],
//               ),
//  */
//
// import 'dart:typed_data';
//
// import '../resources/firestore_methods.dart';
// import '../responsive/mobile_screen_layout.dart';
// import '../utils/colors.dart';
// import '../utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../models/user.dart';
// import '../providers/user_provider.dart';
//
// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddPostScreenState createState() => _AddPostScreenState();
// }
//
// class _AddPostScreenState extends State<AddPostScreen> {
//   Uint8List? _file;
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _titleController = TextEditingController();
//   bool isLoading = false;
//
//   _selectImage(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return SimpleDialog(
//             title: Text('Create a Post'),
//             children: [
//               SimpleDialogOption(
//                 padding: EdgeInsets.all(10.0),
//                 child: Text('Take a Photo'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.camera, 50);
//                   setState(() {
//                     _file = file;
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: EdgeInsets.all(10.0),
//                 child: Text('Choose from Gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.gallery, 100);
//                   setState(() {
//                     _file = file;
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: EdgeInsets.all(10.0),
//                 child: Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   void postImage(String uid, String username, String profImage) async {
//     setState(() {
//       isLoading = true;
//     });
//     //start loading
//     try {
//       //upload to storage and db
//       String res = await FirestoreMethods().uploadPost(
//         _descriptionController.text, _titleController.text, _file!, uid,
//         username, profImage,);
//       if (res == 'success'){
//         setState(() {
//           isLoading = false;
//         });
//         showSnackBar(context, 'Posted!');
//         clearImage();
//       } else {
//         showSnackBar(context, res);
//       }
//     } catch(err){
//       setState(() {
//         isLoading = false;
//       });
//       showSnackBar(context, err.toString());
//     }
//   }
//
//   void clearImage(){
//     setState(() {
//       super.dispose();
//       _descriptionController.dispose();
//       _titleController.dispose();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final User user = Provider
//         .of<UserProvider>(context)
//         .getUser;
//
//     return _file == null
//         ? Center(
//       child: IconButton(
//         onPressed: () => _selectImage(context),
//         icon: Icon(Icons.add_a_photo),
//       ),
//     )
//         : Scaffold(
//       appBar: AppBar(
//         backgroundColor: mobileBackgroundColor,
//         leading: IconButton(
//           onPressed: clearImage,
//           icon: Icon(Icons.arrow_back),
//         ),
//         title: const Text('New Post'),
//         centerTitle: false,
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: const Text(
//               'Post',
//               style: TextStyle(
//                 color: Colors.blueAccent,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//               ),
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             isLoading ? LinearProgressIndicator() : Padding(
//               padding: EdgeInsets.only(top: 0.0),),
//             Divider(),
//
//             Container(
//               height: 300,
//               width: 400,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: MemoryImage(_file!),
//                   )
//               ),
//             ),
//
//             Divider(color: Colors.grey.shade400, thickness: 1.0,),
//
//             Padding(
//               padding: EdgeInsets.all(10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(user.photoUrl!),
//                   ),
//                   SizedBox(
//                       width: MediaQuery
//                           .of(context)
//                           .size
//                           .width * 0.50,
//                       child: Column(
//                         children: [
//
//                           TextField(
//                             controller: _titleController,
//                             decoration: InputDecoration(
//                                 hintText: 'Enter a title',
//                                 border: InputBorder.none
//                             ),
//                             maxLength: 10,
//                           ),
//                           TextField(
//                             controller: _descriptionController,
//                             decoration: InputDecoration(
//                               hintText: 'Write a caption',
//                               border: InputBorder.none,
//                             ),
//                             maxLines: 8,
//                           ),
//
//                         ],
//                       )
//                   ),
//
//                 ],
//               ),
//             ),
//             Divider(),
//           ],
//         ),
//       )
//
//     );
//   }
// }

/*
final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    final XFile? pickedFile2 = await _picker.pickImage(source: ImageSource.camera);

    File image = File(pickedFile!.path);
    File image2 = File(pickedFile2!.path);

    imageClassification(image);
    imageClassification(image2);
 */
