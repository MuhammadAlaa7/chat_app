import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/views/chat_view.dart';
import 'package:scholar_chat/views/login_view.dart';
import 'package:scholar_chat/views/resgister_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

// If you are using the named routes make the id of the home screen / route >>>> '/'
// to avoid the exception >> a global key used multiple times

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        ChatView.id: (context) => ChatView(),
      },
      initialRoute: '/',
    );
  }
}
