import 'package:flutter/material.dart';

class liveTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
              hintText: 'Name',
                hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Age",
                hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                border: UnderlineInputBorder(),
              ),

            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Salary",
                hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Add Employee",style: TextStyle(fontSize: 22),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
