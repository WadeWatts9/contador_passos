import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/health_connect_service.dart';
import 'viewmodels/steps_viewmodel.dart';
import 'views/steps_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider<HealthConnectService>(
          create: (_) => HealthConnectService(),
        ),
        
        // ViewModels
        ChangeNotifierProvider<StepsViewModel>(
          create: (context) => StepsViewModel(
            context.read<HealthConnectService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Contador de Passos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const StepsScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
