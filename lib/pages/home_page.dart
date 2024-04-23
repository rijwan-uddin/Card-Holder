import 'package:cardholder/pages/scan_page.dart';
import 'package:cardholder/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/helper_function.dart';
import 'contact_details.dart';

class homepage extends StatefulWidget {
  static const String routeName = '/';

  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    Provider.of<ContactProvider>(context, listen: false).getAllContacts();
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
        onPressed: () {
          context.goNamed(ScanPage.routeName);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            _fetchData();
          },
          currentIndex: selectedIndex,
          backgroundColor: Colors.blue[100],
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'All'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];

            return Dismissible(
              //swipe left to delete
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Icon(
                    Icons.delete,
                    size: 25,
                    color: Colors.white,
                  )),
              confirmDismiss: _showConfirmationDialog,
              onDismissed: (_) async {
                await provider.deleteContact(contact.id);
                showMsg(context, 'Delete');
              },
              child: ListTile(
                onTap: () => context.goNamed(ContactDetails.routeName,
                    extra: contact.id),
                title: Text(contact.name),
                trailing: IconButton(
                  onPressed: () {
                    provider.updateFavorite(contact);
                  },
                  icon: Icon(contact.favorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Contact'),
              content: Text('Are you sure to delete this contact?'),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    context.pop(false);
                  },
                  child: Text('No'),
                ),
                OutlinedButton(
                  onPressed: () {
                    context.pop(true);
                  },
                  child: Text('Yes'),
                ),
              ],
            ));
  }

  void _fetchData() {
    switch (selectedIndex) {
      case 0:
        Provider.of<ContactProvider>(context, listen: false).getAllContacts();
        break;
      case 1:
        Provider.of<ContactProvider>(context, listen: false)
            .getAllFavoriteContacts();
        break;
    }
  }
}
