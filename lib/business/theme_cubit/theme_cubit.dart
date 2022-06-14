import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business/theme_cubit/theme_state.dart';
import 'package:movie_app/data/network/local/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ChangeAppInitialize());

  bool isDark = false;


  static ThemeCubit get (context) => BlocProvider.of(context);

  void toggle({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppTheme(isDark: isDark));
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        debugPrint( 'dataSaved : $isDark');
        emit(ChangeAppTheme(isDark: isDark));
      });
    }
  }
}
