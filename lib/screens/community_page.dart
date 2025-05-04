import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _exerciseDescController = TextEditingController();
  int _selectedTab = 0;
  String _searchQuery = '';
  String _sortOption = 'Newest';


  @override
  void dispose() {
    _postController.dispose();
    _exerciseController.dispose();
    _exerciseDescController.dispose();
    super.dispose();
  }

  Future<void> _addPost() async {
    if (_postController.text.isEmpty) return;

    await _firestore.collection('posts').add({
      'userId': _auth.currentUser!.uid,
      'userEmail': _auth.currentUser!.email,
      'content': _postController.text,
      'timestamp': Timestamp.now(),
      'type': 'post',
    });

    _postController.clear();

    // Add this to the _addPost method:
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added successfully')),
      );
    }
  }

  Future<void> _addExercise() async {
    if (_exerciseController.text.isEmpty ||
        _exerciseDescController.text.isEmpty) return;

    await _firestore.collection('posts').add({
      'userId': _auth.currentUser!.uid,
      'userEmail': _auth.currentUser!.email,
      'title': _exerciseController.text,
      'description': _exerciseDescController.text,
      'timestamp': Timestamp.now(),
      'type': 'exercise',
    });

    _exerciseController.clear();
    _exerciseDescController.clear();
  }

  Widget _buildPostInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _postController,
            decoration: InputDecoration(
              labelText: 'Share your workout thoughts',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _addPost,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _exerciseController,
            decoration: const InputDecoration(
              labelText: 'Exercise name',
            ),
          ),
          TextField(
            controller: _exerciseDescController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            maxLines: 3,
          ),
          ElevatedButton(
            onPressed: _addExercise,
            child: const Text('Share Exercise'),
          ),
        ],
      ),
    );
  }

  Widget _buildPostItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['timestamp'] as Timestamp;
    final dateTime = timestamp.toDate();
    final formattedDate = DateFormat('MMM d, y - h:mm a').format(dateTime);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(data['userEmail'].toString()[0].toUpperCase()),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['userEmail']),
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(data['content'] ?? data['title']),
            if (data['type'] == 'exercise') ...[
              const SizedBox(height: 8),
              Text(
                data['description'],
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        if (_selectedTab == 0) _buildPostInput(),
        if (_selectedTab == 1) _buildExerciseInput(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Поисковая строка
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              // Выпадающее меню сортировки
              DropdownButton<String>(
                value: _sortOption,
                items: const [
                  DropdownMenuItem(
                    value: 'Newest',
                    child: Text('Newest'),
                  ),
                  DropdownMenuItem(
                    value: 'Oldest',
                    child: Text('Oldest'),
                  ),
                  DropdownMenuItem(
                    value: 'A-Z',
                    child: Text('A-Z'),
                  ),
                  DropdownMenuItem(
                    value: 'Z-A',
                    child: Text('Z-A'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _sortOption = value!;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('posts').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              var docs = snapshot.data?.docs ?? [];

              // Фильтрация по поиску
              docs = docs.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final content = (data['content'] ?? data['title'] ?? '')
                    .toString()
                    .toLowerCase();
                final description = (data['description'] ?? '')
                    .toString()
                    .toLowerCase();
                return content.contains(_searchQuery) ||
                    description.contains(_searchQuery);
              }).toList();

              // Сортировка
              docs.sort((a, b) {
                final aData = a.data() as Map<String, dynamic>;
                final bData = b.data() as Map<String, dynamic>;

                if (_sortOption == 'Newest') {
                  return (bData['timestamp'] as Timestamp)
                      .compareTo(aData['timestamp'] as Timestamp);
                } else if (_sortOption == 'Oldest') {
                  return (aData['timestamp'] as Timestamp)
                      .compareTo(bData['timestamp'] as Timestamp);
                } else {
                  final aText = (aData['content'] ?? aData['title'] ?? '')
                      .toString()
                      .toLowerCase();
                  final bText = (bData['content'] ?? bData['title'] ?? '')
                      .toString()
                      .toLowerCase();
                  return _sortOption == 'A-Z'
                      ? aText.compareTo(bText)
                      : bText.compareTo(aText);
                }
              });

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return _buildPostItem(docs[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // У вас 2 вкладки: Posts и Exercises
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Community'),
          bottom: TabBar(
            onTap: (index) => setState(() => _selectedTab = index),
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Exercises'),
            ],
          ),
        ),
        body: _buildContent(),
      ),
    );
  }

}