

class ThemeState {}

class ChangeAppInitialize extends ThemeState{}
class ChangeAppTheme extends ThemeState{
  bool?  isDark;

  ChangeAppTheme({this.isDark});
}