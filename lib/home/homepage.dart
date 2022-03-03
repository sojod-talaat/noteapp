import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List notes = [
    {'name': 'NO PAIN NO GAIN', 'image': '3.png'},
    {'name': 'Do smart,Do less', 'image': '2.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '3.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '2.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '3.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '2.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '3.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '2.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '3.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '2.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '3.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '2.png'},
    {'name': 'NO PAIN NO GAIN', 'image': '3. png'},
    {'name': 'NO PAIN NO GAIN', 'image': '2.png'},
  ];

  get images => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.of(context).pushNamed('Add');
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('login');
              },
              icon: Icon(Icons.exit_to_app))
        ],
        backgroundColor: Colors.orangeAccent,
        title: Container(
          padding: EdgeInsets.only(left: 19),
          child: Text(
            'Homepage',
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, i) {
              return Dismissible(
                  key: Key('$i'),
                  child: note(
                    notes[i],
                  ));
            }),
      ),
    );
  }
}

class note extends StatelessWidget {
  final notes;

  note(
    this.notes,
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      // child: Container(
      //padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset('images/2.png'),
          ),
          Expanded(
              flex: 4,
              child: ListTile(
                subtitle: Text('${notes['name']}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
              )),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
    //);
  }
}
