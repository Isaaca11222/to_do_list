import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/widget/add_todo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/widget/completed.list.widget.dart';
import 'package:to_do_list/widget/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  final confettiController = ConfettiController();

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(
        onChecked: () {
          confettiController.play();
        },
      ),
      const CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "To do list",
              style: GoogleFonts.lora(fontSize: 30),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(185, 60, 75, 20),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(143, 44, 43, 43),
        unselectedItemColor:
            const Color.fromARGB(255, 32, 32, 32).withOpacity(0.7),
        selectedItemColor: const Color.fromARGB(255, 241, 238, 238),
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
      body: Stack(
        children: [
          tabs[selectedIndex],
          ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.2,
            shouldLoop: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          builder: (context) => const AddTodoDialogWidget(),
          context: context,
          barrierDismissible: false,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
