import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app_router.dart';
import 'package:movie_app/business/theme_cubit/theme_cubit.dart';
import 'package:movie_app/business/theme_cubit/theme_state.dart';
import 'package:movie_app/presentation/style/theme.dart';

import 'data/network/local/shared_preferences.dart';
import 'data/network/remote/dio_helper.dart';
import 'my_bloc_observer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.initCacheHelper();
  bool? isDarkMode = CacheHelper.getData(key: 'isDark');
  debugPrint('isDarkMode : $isDarkMode');
  BlocOverrides.runZoned(() {
    runApp(MyApp(
      appRouter: AppRouter(),
      isDark: isDarkMode,
    ));
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final bool? isDark;

  const MyApp({Key? key, required this.appRouter, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..toggle(fromShared: isDark)),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
          listener: (context, state) {}),
    );
  }
}
/*

* */
