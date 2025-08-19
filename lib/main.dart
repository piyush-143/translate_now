import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/view/splash_view.dart';
import 'package:translate_now/view_modal/bottom_app_bar_provider.dart';
import 'package:translate_now/view_modal/db_provider.dart';
import 'package:translate_now/view_modal/image_provider.dart';
import 'package:translate_now/view_modal/rating_provider.dart';
import 'package:translate_now/view_modal/speech_to_text_provider.dart';
import 'package:translate_now/view_modal/translation_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomAppBarProvider()),
        ChangeNotifierProvider(create: (context) => TranslationProvider()),
        ChangeNotifierProvider(create: (context) => ImgProvider()),
        ChangeNotifierProvider(create: (context) => DBProvider()),
        ChangeNotifierProvider(create: (context) => RatingProvider()),
        ChangeNotifierProvider(create: (context) => SpeechToTextProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(),
          textTheme: TextTheme(bodyMedium: GoogleFonts.roboto()),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
