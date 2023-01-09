import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_cars/bloc/cars/cars_cubit.dart';
import 'package:fresh_cars/data/api_service/api_service.dart';
import 'package:fresh_cars/data/repositories/cars_repo.dart';
import 'package:fresh_cars/ui/main_screen/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => CarsRepo(apiService: ApiService()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            CarsCubit(carsRepo: context.read<CarsRepo>())..fetchAllCars(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh Cars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
