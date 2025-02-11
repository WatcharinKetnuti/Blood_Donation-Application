import 'package:flutter/material.dart';
import 'widgets/bottom_navigator.dart';

void main() => runApp(
    MaterialApp(
        title: 'Blood Donation',
        home: BottomNavBar()
    )
);
// void main() => runApp(
//   MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_)=>ApiService())
//       ],
//       child: MaterialApp(
//         home: BottomNavBar()
//       )
//   )
// );
