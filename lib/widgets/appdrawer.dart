import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartclinic/screens/qr_screen.dart';

import '../screens/upcoming_appointments_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Appointments'),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(UpcoimngAppointmentsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.qr_code),
            title: Text('My QR'),
            onTap: () {
              Navigator.of(context).pushNamed(QrScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
