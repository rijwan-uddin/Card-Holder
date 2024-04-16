import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  static const String routeName= '/';
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),

      ),
      bottomNavigationBar:  BottomAppBar(
        padding:EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child:  BottomNavigationBar(
          
          onTap: (index){
            setState(() {
              selectedIndex= index;
            });

          },
          currentIndex: selectedIndex,

          backgroundColor: Colors.blue[100],
          items:  const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'All'
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite'
            ),
          ],
        ),
      ),
    );
  }
}

















