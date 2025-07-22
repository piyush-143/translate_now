import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view/splash_view.dart';
import 'package:translate_now/view_modal/bottom_app_bar_provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomAppBarProvider()),
        ChangeNotifierProvider(create: (context) => TranslationProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(),
          textTheme: TextTheme(bodyMedium: GoogleFonts.roboto()),
        ),

        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final translator = GoogleTranslator();
//   String input = "My name is sachin";
//   var translated;
//   bool loading = false;
//
//   final onDeviceTraslation = OnDeviceTranslator(
//     sourceLanguage: TranslateLanguage.english,
//     targetLanguage: TranslateLanguage.hindi,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(input),
//             !loading ? Text("") : Text(translated.toString()),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           loading = true;
//           // translated = await translator.translate(input, to: 'hi');
//           onDeviceTraslation.translateText(input).then((value) {
//             setState(() {
//               translated = value;
//             });
//           });
//         },
//         tooltip: 'Translate',
//         child: const Icon(Icons.translate),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
