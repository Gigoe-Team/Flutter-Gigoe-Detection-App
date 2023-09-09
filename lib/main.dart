import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gigoe_detection_app/features/presentation/bloc/classification_bloc.dart';
import 'package:gigoe_detection_app/features/presentation/bloc/img_response_bloc.dart';
import 'package:gigoe_detection_app/features/presentation/pages/add_photo_page.dart';
import 'package:gigoe_detection_app/features/presentation/pages/home_page.dart';
import 'package:gigoe_detection_app/features/presentation/pages/login_page.dart';
import 'package:gigoe_detection_app/features/presentation/widgets/bottom_nav_bar.dart';
import 'features/presentation/pages/splash_page.dart';
import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await di.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<ClassificationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ImgResponseBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => MyHomePage(),
          '/signIn-page': (context) => LoginPage(),
          '/add_photo': (context) => AddPhoto(),
          '/add_photos': (context) => AddPhoto(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BottomNavBar();
  }
}
