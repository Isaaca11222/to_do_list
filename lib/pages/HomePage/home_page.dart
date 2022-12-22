import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Container(),
      Container(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("To do list"),
        backgroundColor: Color.fromARGB(185, 60, 75, 20),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(143, 44, 43, 43),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Todo list",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
              size: 28,
              color: Color.fromARGB(255, 119, 187, 121),
            ),
            label: "Completed",
          ),
        ],
      ),
    );
  }
}
