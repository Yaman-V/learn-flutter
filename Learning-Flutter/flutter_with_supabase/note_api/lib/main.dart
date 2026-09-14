import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mactbknubslpcoiogzit.supabase.co',
    publishableKey: 'sb_publishable_FvJfJRuAV2Uy0ESHJZZ40A_fTMQ-Qjw',
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // access the DB
  final mySupabase = Supabase.instance.client;
  List<dynamic> notes = [];

  void getAllNotes() async {
    final res = await mySupabase
        .from('Notes')
        .select()
        .order("id", ascending: false);

    // Save all the notes in the list
    setState(() {
      notes = res;
    });
  }

  // This ofc async as we are aitnig for the supaBase
  void addNote(String titile, String content) async {
    await mySupabase.from("Notes").insert({
      'titile': titile,
      'content': content,
    });

    getAllNotes();
  }

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
