import 'package:flutter/material.dart';
import 'package:movie_app/app_router.dart';

import 'data/network/remote/dio_helper.dart';
import 'data/repository/fetch_data_repository.dart';

void main() {
  DioHelper.init();
  Repository.getPopularMovies();
  Repository.topRatedMovies();
  Repository.getTrendingMovies();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
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
