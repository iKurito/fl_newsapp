import 'package:fl_newsapp/src/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_newsapp/src/pages/tabs_page.dart';
import 'package:fl_newsapp/src/theme/tema.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const TabsPage(),
        theme: miTema,
      ),
    );
  }
}