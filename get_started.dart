import 'package:flutter/material.dart';
import 'package:transit_app/components/my_button.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    Color bgColor = const Color(0xFF24293E);
    Color textColor = const Color(0xFFF4F5FC);
    Color accColor = const Color(0xFFBEBBFF);
    Color secColor = const Color(0xFFCCCCCC);

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.directions_bus,
                    color: accColor,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "TransitEase",
                    style: TextStyle(
                      color: secColor,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 50,
              ),

              Text(
                "Find Your Bus Station With TransitEase",
                style: TextStyle(color: textColor, fontSize: 35),
              ),

              const SizedBox(
                height: 50,
              ),

              // get started button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    text: "Get Started",
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ],
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bus_alert,
                      size: 250,
                      color: accColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
