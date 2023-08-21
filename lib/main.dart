import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What\'s in my fridge?',
      theme: ThemeData(
          cardTheme: CardTheme(color: Colors.grey[800]),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.grey,
              brightness: Brightness.dark,
              background: Colors.grey[900]),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[850],
            foregroundColor: Colors.white,
          )),
      home: myHomePage(),
    );
  }
}

class myHomePage extends StatefulWidget {
  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  String title = "";
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    title =
        ["What's in my Fridge", "Saved Items"][_ThebottomBarState._currentPage];
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: setState(() => title = [
            "What's in my Fridge",
            "Saved Items"
          ][_ThebottomBarState._currentPage]),
      appBar: AppBar(
        title: Text(title),
        //  style: TextStyle(color: Colors.white)),
        // backgroundColor: Colors.deepPurple,
      ),
      // body: NewPage(), <-------- This has caused a duplicate button behind
      //                        the bottom nav bar
      bottomSheet: ThebottomBar(),
    );
  }
}

class ThebottomBar extends StatefulWidget {
  const ThebottomBar({super.key});

  @override
  State<ThebottomBar> createState() => _ThebottomBarState();
}

class _ThebottomBarState extends State<ThebottomBar> {
  static int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: const Duration(milliseconds: 350),
        selectedIndex: _currentPage,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.star),
            label: "New",
          ),
          NavigationDestination(
              icon: Icon(Icons.save_alt_rounded), label: "Saved Items"),
        ],
        onDestinationSelected: (value) => setState(() {
          _currentPage = value;
        }),
      ),
      body: [
        NewPage(),
        SavedItemsPage(),
      ][_currentPage],
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewItem()),
          );
        },
        icon: Icon(
          Icons.add,
          color: Colors.blueGrey[300],
        ),
        label: Text(
          "Add New Item",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[850]),
      ),
    );
  }
}

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Scaffold(
        // appBar: AppBar(title: Text("Saved Items")),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                    7, (index) => ItemWidget(text: 'Item $index')),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Center(child: Text(text)),
      ),
    );
  }
}

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Back",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter food name"),
              ),
            ],
          ),
        ));
  }
}
