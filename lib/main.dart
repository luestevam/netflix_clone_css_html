import 'package:flutter/material.dart';
import 'package:olx/route_generator.dart';
import 'package:olx/views/anuncios.dart';


final ThemeData TemaPadrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  accentColor: Color(0xff7b1f02),

);

void main () => runApp(MaterialApp(
  title: "OLX",
  home: Anuncios(),
  theme: TemaPadrao,
  initialRoute: "/",
  onGenerateRoute: RouteGenerator.generateRoute,
  debugShowCheckedModeBanner: false,

));