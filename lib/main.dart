import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Add_Page.dart';
import 'Provider/main_provider.dart';
import 'Provider/dark_theme_preferences.dart';
import 'Provider/theme_data.dart';
import 'home_page.dart';

 Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
 }
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
          home: const HomeHome(),
          debugShowCheckedModeBanner: false,
        );
  }
}

class HomeHome extends StatefulWidget {
  const HomeHome({super.key});

  @override
  State<HomeHome> createState() => _HomeHomeState();
}

class _HomeHomeState extends State<HomeHome> {
  DarkThemeIcon themeChangeProvider = DarkThemeIcon();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme1 =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }
  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_){
          return themeChangeProvider;
        })
      ],
      child: Consumer<DarkThemeIcon>(builder:(context,themeData,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ('darkMode'),
          theme: Styles.themeData(themeChangeProvider.darkTheme1, context),
          home:HomePage(),
        );
      }),
      
      );
  }
}