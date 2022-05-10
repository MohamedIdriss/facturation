import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  sendEmail() async {
    String username = 'fadef85963@abincol.com';
    String password = '';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'MyBench')
      ..recipients.add('idrissmouhamed841@gmail.com')
      ..subject = 'Bienvenue à MyBench 😀'
    //..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>Vote employeur vous a donner l\'access à l\'application MyBench</h1>\n<h2>Voici votre coordonnées:</h2>\n<h3>Email: $username <br /> Mot de passe: 26995499</h3>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendEmail,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

