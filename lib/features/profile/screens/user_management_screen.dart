
import 'package:flutter/material.dart';


class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final List<Map<String, String>> _users = [
    {'name': 'Admin Principal', 'email': 'admin@smartstock.ma', 'role': 'Super Admin'},
    {'name': 'Sarah Gestionnaire', 'email': 'sarah@smartstock.ma', 'role': 'Gestionnaire Stock'},
    {'name': 'Yassine Vendeur', 'email': 'yassine@smartstock.ma', 'role': 'Vendeur'},
  ];

  void _addUser() {
    String name = '';
    String email = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un utilisateur'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nom'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => email = value,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty && email.isNotEmpty) {
                setState(() {
                  _users.add({'name': name, 'email': email, 'role': 'Utilisateur'});
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(int index) {
    setState(() {
      _users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des Utilisateurs')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${user['email']} • ${user['role']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _deleteUser(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
