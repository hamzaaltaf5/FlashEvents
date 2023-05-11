import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/colors.dart';
import '../utils/global_variable.dart';
import 'package:flutter/material.dart';
import '../screens/add_post_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MobileScreenLayout extends StatefulWidget {
  @override
  MobileScreenLayoutState createState() => MobileScreenLayoutState();
}

class MobileScreenLayoutState extends State<MobileScreenLayout> {

  int _currentIndex = 0;
  // final List<Widget> _children = [
  //   Center(child: Text('Home'),),
  //   Center(child: Text('Search'),),
  //   AddPostScreen(),
  //   Center(child: Text('Favorite'),),
  //   Center(child: Text('User'),),
  // ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  String username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // int _page = 0;
    // late PageController pageController;

    // @override
    // void initState(){
    //   super.initState();
    //   pageController = PageController();
    // }
    //
    // void dispose(){
    //   super.dispose();
    //   pageController.dispose();
    // }
    //
    // void navigationTapped(int page){
    //   pageController.jumpToPage(page);
    // }
    //
    // void onPageChanged(int page){
    //   setState(() {
    //     _page = page;
    //   });
    // }

    return Scaffold(
        body: homeScreenItems[_currentIndex],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric( horizontal: 1.0, vertical: 2.0 ),
          child: GNav(
            onTabChange: onTappedBar,
            activeColor: Colors.white,
            tabBackgroundGradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [ Color(0xFF004D40), Color( 0xFF009688 ) ]
            ),
            gap: 2.0,
            padding: EdgeInsets.all(10.0),
            tabs: [

              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),

              GButton(
                icon: Icons.search,
                text: 'Search',
              ),

              GButton(
                icon: Icons.add_a_photo,
                text: 'Add Post',
              ),

              GButton(
                icon: Icons.favorite,
                text: 'Activity',
              ),

              GButton(
                icon: Icons.account_circle_outlined,
                text: 'User',
              ),

            ],
          ),
        )
    );

    // return Scaffold(
    //   body: PageView(
    //     children: _children,
    //     controller: pageController,
    //     onPageChanged: onPageChanged,
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: [
    //       BottomNavigationBarItem(
    //         backgroundColor: Colors.amber,
    //         icon: Icon(
    //           Icons.home,
    //           color: _page == 0 ? Colors.teal : Colors.black,
    //         ),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.search, color: _page == 1 ? Colors.teal : Colors.black,),
    //         label: 'Search',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.backpack, color: _page == 2 ? Colors.teal : Colors.black,),
    //         label: 'Booking',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.favorite, color: _page == 3 ? Colors.teal : Colors.black,),
    //         label: 'Favorite',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.person, color: _page == 4 ? Colors.teal : Colors.black,),
    //         label: 'Profile',
    //       ),
    //     ],
    //     onTap: navigationTapped,
    //   ),
    // );
  }
}
