import 'package:flutter/material.dart';

class Document extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Title'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit action
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Document Header',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Suspendisse varius enim in eros elementum tristique. '
                  'Duis cursus, mi quis viverra ornare, eros dolor interdum nulla, '
                  'ut commodo diam libero vitae erat. Aenean faucibus nibh et justo '
                  'cursus id rutrum lorem imperdiet. Nunc ut sem vitae risus tristique '
                  'posuere.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Save action
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.purple),
                  ),
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Cancel action
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
