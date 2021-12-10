import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pix_key/controller/pix_key_controller.dart';
import 'package:pix_key/service/service.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => PixKeyController(ServiceApplication()),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Pix',
      home: const HomePage(),
    );
  }
}
