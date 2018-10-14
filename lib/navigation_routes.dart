
import 'package:flutter/material.dart';

class NavigationRoutes {
  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen(),
        );
        break;
      case '/speakers':
        return MaterialPageRoute(builder: (BuildContext context) => Speakers(),);
        break;
      case '/events':
        return MaterialPageRoute(builder: (BuildContext context) => Events(),);
        break;
      default:
        return MaterialPageRoute(builder: (BuildContext context) => Events(),);
    }
  }
}

Widget Events() {
  return Container();
}

Widget Speakers() {
  return Container();
}

Widget SplashScreen() {
  return Container();
}
