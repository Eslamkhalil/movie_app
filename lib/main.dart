import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app_router.dart';

import 'data/network/remote/dio_helper.dart';
import 'my_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  DioHelper.getMovieDetails(338953);
  BlocOverrides.runZoned(() {
    runApp(MyApp(
      appRouter: AppRouter(),
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
