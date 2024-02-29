import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ficha de RPG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CharacterSheet(),
    );
  }
}

class InventoryItem {
  String name;
  int quantity;

  InventoryItem({required this.name, required this.quantity});
}

class CharacterSheet extends StatefulWidget {
  @override
  _CharacterSheetState createState() => _CharacterSheetState();
}

class _CharacterSheetState extends State<CharacterSheet> {
  String name = '';
  String characterClass = '';
  String race = '';
  int level = 1;
  int hitPoints = 10;
  String description = '';
  List<InventoryItem> inventory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha de RPG'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nome do Personagem:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Classe:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    characterClass = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Raça:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    race = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Nível:',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        level = level > 1 ? level - 1 : level;
                      });
                    },
                  ),
                  Text(
                    '$level',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        level++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Pontos de Vida:',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        hitPoints = hitPoints > 0 ? hitPoints - 1 : hitPoints;
                      });
                    },
                  ),
                  Text(
                    '$hitPoints',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        hitPoints++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Descrição:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                maxLines: null, // Permitir múltiplas linhas
              ),
              SizedBox(height: 20.0),
              Text(
                'Inventário:',
                style: TextStyle(fontSize: 18.0),
              ),
              ReorderableListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = inventory.removeAt(oldIndex);
                    inventory.insert(newIndex, item);
                  });
                },
                children:
                    inventory.map((item) => buildInventoryItem(item)).toList(),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  _addInventoryItem();
                },
                child: Text('Adicionar Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInventoryItem(InventoryItem item) {
    return ListTile(
      key: ValueKey(item),
      title: Text(item.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (item.quantity > 1) {
                  item.quantity--;
                } else {
                  inventory.remove(item);
                }
              });
            },
          ),
          Text('${item.quantity}'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                item.quantity++;
              });
            },
          ),
        ],
      ),
    );
  }

  void _addInventoryItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String itemName = '';
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: TextField(
            onChanged: (value) {
              itemName = value;
            },
            decoration: InputDecoration(hintText: 'Nome do Item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  inventory.add(InventoryItem(name: itemName, quantity: 1));
                });
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
