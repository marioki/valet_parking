import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:valet_parking/car_details/bloc/car_details_bloc.dart';
import 'package:valet_parking/home/bloc/bloc/home_bloc.dart';
import 'package:valet_parking/home/home.dart';
import 'package:valet_parking/services/car_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CarService(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                HomeBloc(RepositoryProvider.of<CarService>(context))
                  ..add(const StartServicesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                CarDetailsBloc(RepositoryProvider.of<CarService>(context)),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Valet Parking',
      home: HomePage(),
    );
  }
}
