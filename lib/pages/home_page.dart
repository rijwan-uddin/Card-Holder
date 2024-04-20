import 'package:cardholder/pages/scan_page.dart';
import 'package:cardholder/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  static const String routeName= '/';
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int selectedIndex = 0;
  @override
  void didChangeDependencies() {
   Provider.of<ContactProvider>(context,listen: false).getAllContacts();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.goNamed(ScanPage.routeName);

        },
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
      body: Consumer<ContactProvider>(
        builder: (context,provider,child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index){
            final contact = provider.contactList[index];
            return ListTile(
              title: Text(contact.name),
              trailing: IconButton(
                onPressed: (){},
                icon:  Icon(contact.favorite ? Icons.favorite: Icons.favorite_border),
              ),
            );
          },

        ),
      ),
    );
  }
}

















