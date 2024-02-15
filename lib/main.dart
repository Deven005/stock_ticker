import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:stock_ticker/Screens/BottomNavBarScreen.dart';
import 'package:stock_ticker/Utils/MyWidgets/MyWidgets.dart';
import 'package:stock_ticker/Utils/Utils.dart';

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'navigatorKey');
final MyWidgets myWidgets = MyWidgets();
final Utils utils = Utils();
IO.Socket socket = IO.io('http://192.168.1.2:3000', <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': true,
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  socket.onConnect((_) {
    debugPrint('connected');
  });
  socket.on('connect', (number) {
    debugPrint('Connected to server');
  });
  socket.onDisconnect((_) => debugPrint('disconnect'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: kDebugMode,
        navigatorKey: navigatorKey,
        theme: ThemeData(
            textTheme: GoogleFonts.playfairDisplayTextTheme(
                    Theme.of(context).textTheme)
                .copyWith(
              bodyMedium: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyMedium),
              displayLarge: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            fontFamily: GoogleFonts.oswald().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
                TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
              },
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue, foregroundColor: Colors.white)),
        home: const BottomNavBarScreen(),
      ),
    );
  }
}
