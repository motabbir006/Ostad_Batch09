import 'package:flutter/material.dart';

class Contact {
  String name;
  String number;

  Contact({required this.name, required this.number});
}

class Contact_list extends StatefulWidget {
  const Contact_list({super.key});

  @override
  _Contact_listState createState() => _Contact_listState();
}

class _Contact_listState extends State<Contact_list> {
  final List<Contact> items = [];


  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  final numberRegex = RegExp(r'^\d{1,11}$');

  void addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (name.isEmpty || number.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Both name and number are required.")),
      );
      return;
    }
    if (!nameRegex.hasMatch(name)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Name must contain only letters and spaces.")),
      );
      return;
    }

    if (!numberRegex.hasMatch(number)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Number must be numeric and maximum 11 digits.")),
      );
      return;
    }
    setState(() {
      items.add(Contact(name: name, number: number));
    });
    nameController.clear();
    numberController.clear();
  }


  void removeContact(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you for delete?'),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                removeContact(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6E7F8D),
        centerTitle: true,
        title: Text(
          'Contact List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: nameController,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
              ),

            ),
            const SizedBox(height: 14),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Number',
                hintStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6E7F8D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: addContact,
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person, size: 40),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        items[index].name,
                        style: const TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        items[index].number,
                        style:
                        const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                    trailing: IconButton(
                      icon:
                      const Icon(Icons.call, color: Colors.blue, size: 30),
                      onPressed: () {},
                    ),
                    onLongPress: () {
                      _showDeleteConfirmationDialog(context, index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
