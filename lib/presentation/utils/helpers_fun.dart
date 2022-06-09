
import 'package:flutter/material.dart';

 navigateTo({required BuildContext context, required String screen, dynamic args}) => Navigator.pushNamed(context, screen ,arguments: args);