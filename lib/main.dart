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
  int strength = 10;
  int constitution = 10;
  int intelligence = 10;
  int wisdom = 10;
  int hitPoints = 0;
  int mana = 0;
  String description = '';
  List<InventoryItem> inventory = [];

  @override
  Widget build(BuildContext context) {
    // Recalcula os pontos de vida e mana com base nos atributos
    hitPoints = constitution + strength;
    mana = intelligence + wisdom;

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
                'Força:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    strength = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Constituição:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    constitution = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Inteligência:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    intelligence = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Sabedoria:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    wisdom = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Pontos de Vida:',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                '$hitPoints',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Mana:',
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                '$mana',
                style: TextStyle(fontSize: 18.0),
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
