import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'providers/crop_provider.dart';
import 'providers/weather_provider.dart';
import 'providers/locale_provider.dart';
import 'models/crop.dart';
import 'screens/notifications_screen.dart';
import 'services/notification_service.dart';
import 'utils/weather_icons.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(CropAdapter());
    await Hive.openBox<Crop>('crops_box');
    await Hive.openBox('settings_box');
    await Hive.openBox('weather_box');
    await Hive.openBox('lottie_cache');
    await NotificationService.init();

    runApp(
          MultiProvider(
                  providers: [
                            ChangeNotifierProvider(create: (context) => CropProvider()),
                            ChangeNotifierProvider(create: (context) => WeatherProvider()),
                            ChangeNotifierProvider(create: (context) => LocaleProvider()),
                          ],
                  child: const AgroHavoApp(),
                ),
        );
}

class AgroHavoApp extends StatelessWidget {
    const AgroHavoApp({super.key});

    @override
    Widget build(BuildContext context) {
          return MaterialApp(
                  title: 'Agro Havo',
                  theme: ThemeData(
                            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
                            useMaterial3: true,
                            textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
                          ),
                  supportedLocales: const [
                            Locale('uz'),
                            Locale('ru'),
                          ],
                  localizationsDelegates: const [
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                  home: const MainScreen(),
                  debugShowCheckedModeBanner: false,
                );
    }
}
