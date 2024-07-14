import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const CommonLayout(
      {super.key, required this.child, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    Color accColor = const Color(0xFFBEBBFF);
    Color bgColor = const Color(0xFF24293E);
    Color textColor = const Color(0xFFF4F5FC);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: accColor),
        leading: Icon(
          Icons.directions_bus,
          size: 25,
          color: accColor,
        ),
        title: Text(
          "TransitEase",
          style: TextStyle(
            fontSize: 25,
            color: textColor,
          ),
        ),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgColor,
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/map');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/trip');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/account');
              break;
          }
        },
        selectedItemColor: Colors.grey,
        unselectedItemColor: accColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trip_origin),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
