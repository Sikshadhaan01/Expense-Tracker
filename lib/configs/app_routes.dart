// import 'package:academic_chatbot/pages/chat_bot_page.dart';
import 'package:expense_tracker/components/bottom_nav_bar.dart';
import 'package:expense_tracker/pages/addgroup_page.dart';
// import 'package:expense_tracker/pages/addgroup_page.dart';
import 'package:expense_tracker/pages/budgets_page.dart';
import 'package:expense_tracker/pages/category_page.dart';
import 'package:expense_tracker/pages/login_page.dart';
import 'package:expense_tracker/pages/signup_page.dart';
import 'package:expense_tracker/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  final GoRouter router =
      GoRouter(initialLocation: '/splashscreen', routes: <RouteBase>[
    GoRoute(
        path: "/",
        name: 'home',
        // builder: (context, state) {
        //   return Scaffold(body: Text('hello'),);
        // },
        pageBuilder: (context, state) {
          return const MaterialPage(child: BottomNavBar());
        },
        routes: []),
    GoRoute(
      name: "signup",
      path: "/signup",
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpPage());
      },
    ),
    GoRoute(
      name: "login",
      path: "/login",
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginPage());
      },
    ),
    GoRoute(
      name: 'splashscreen',
      path: '/splashscreen',
      pageBuilder: (context, state) =>
          const MaterialPage(child: SplashScreen()),
    ),
    GoRoute(
      name: "categorypage",
      path: "/categorypage",
      pageBuilder: (context, state) =>
          const MaterialPage(child: CategoryPage()),
    ),
    GoRoute(
      name: "addgroup",
      path: "/addgroup",
      pageBuilder: (context, state) =>
          const MaterialPage(child: AddGroup()),
    ),
     GoRoute(
      name: "budgetspage",
      path: "/budgetspage",
      pageBuilder: (context, state) =>
          const MaterialPage(child: BudgetPage()),
    )
  ]);
}
