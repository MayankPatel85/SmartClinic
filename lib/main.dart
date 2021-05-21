import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartclinic/providers/appointments.dart';
import 'package:smartclinic/screens/auth_screen.dart';
import 'package:smartclinic/screens/qr_screen.dart';
import 'package:smartclinic/screens/splash_screen.dart';

import './screens/launch_screen.dart';
import './screens/doc_info.dart';
import './screens/doctor_detail_screen.dart';
import './screens/appointment_screen.dart';
import './screens/upcoming_appointments_screen.dart';
import './providers/doctors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Doctors()),
        ChangeNotifierProvider(create: (ctx) => Appointments())
      ],
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Clinic',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black)),
          ),
          home: snapshot.connectionState != ConnectionState.done
              ? SplashScreen()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, authSnapshot) {
                    if (authSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    if (authSnapshot.hasData) {
                      return LaunchScreen();
                    }
                    return AuthScreen();
                  },
                ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            LaunchScreen.routeName: (ctx) => LaunchScreen(),
            DocInfo.routeName: (ctx) => DocInfo(),
            AppointmentScreen.routeName: (ctx) => AppointmentScreen(),
            DoctorDetail.routeName: (ctx) => DoctorDetail(),
            UpcoimngAppointmentsScreen.routeName: (ctx) =>
                UpcoimngAppointmentsScreen(),
            QrScreen.routeName: (ctx) => QrScreen(),
          },
        ),
      ),
    );
  }
}
