
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/pages/account/account_page.dart';
import 'package:flutter_food_delivery_app/pages/cart/cart_history.dart';
import 'package:flutter_food_delivery_app/pages/home/main_food_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // var _selectedIndex = 0;

  late PersistentTabController _controller;

  @override
  void initState()
  {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  /*List pages = [
    MainFoodPage(),
    Container(
      child: Center(child: Text('Next page')),
    ),
    Container(
      child: Center(child: Text('Next next Page')),
    ),
    Container(
      child: Center(child: Text('Next next next page')),
    ),
  ];*/

  /*void onTapNav(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }*/

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              label: 'history'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'cart'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'account'
          ),
        ],
      ),
    );
  }*/

  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      Container(
        child: Center(
          child: Text('Empty'),
        ),
      ),
      const CartHistory(),
      const AccountPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.archive),
        title: ("Archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Account"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }


}
