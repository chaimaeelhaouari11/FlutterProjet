
import 'package:flutter/material.dart';


class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _controller = TextEditingController();
  String _selectedCategory = 'Bug';

  void _submitReport() {
    if (_controller.text.isEmpty) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Merci !'),
        content: const Text('Votre signalement a été envoyé avec succès. Notre équipe technique va l\'analyser.'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context); // Ferme le dialogue
            Navigator.pop(context); // Retourne au profil
          }, child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signaler un problème')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quel type de problème rencontrez-vous ?', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: ['Bug', 'Performance', 'Interface', 'Autre'].map((String category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),
            const SizedBox(height: 24),
            const Text('Description du problème', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Décrivez ici ce qui s\'est passé...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReport,
                child: const Text('Envoyer le rapport'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
