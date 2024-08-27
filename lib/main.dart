import 'package:ChatApp/app.dart';
import 'package:ChatApp/screens/home_screen.dart';
import 'package:ChatApp/screens/select_user_screen.dart';
import 'package:ChatApp/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() {
  final client = StreamChatClient(streamKey);
  runApp( MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, 
    required this.client});

  final StreamChatClient client;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return StreamChatCore(
            client: client,
            child: child!
        );
      },
      title: 'Chat App',
      home: SelectUserScreen(),
    );
  }
}


   