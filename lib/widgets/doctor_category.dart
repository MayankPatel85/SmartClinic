import 'package:flutter/material.dart';
import 'package:smartclinic/widgets/category_container.dart';

class DoctorCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var cat = Provider.of<Doctors>(context);
    var category = ['Dental', 'Check-Up', 'Eye', 'First-Aid'];
    // return Container(
    //   height: 120,
    //   width: double.infinity,
    //   margin: EdgeInsets.only(left: 10, right: 10, top: 20),
    //   child: GridView.count(
    //     crossAxisCount: 1,
    //     scrollDirection: Axis.horizontal,
    //     children: [
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (ctx, index) {
          return CategoryContainer(
            category: category,
            title: category[index],
            icon: 'assets/svg/${category[index]}.svg',
            press: () {
              Navigator.of(context)
                  .pushNamed('/doc-info', arguments: category[index]);
            },
          );
        });
    // CategoryContainer(
    //   category: category,
    //   title: category[0],
    //   icon: 'assets/icons/dental-checkup.png',

    // ),
    // CategoryContainer(
    //   category: category,
    //   title: category[1],
    //   icon: 'assets/icons/stethoscope.png',
    //   press: () {
    //     Navigator.of(context)
    //         .pushNamed('/doc-info', arguments: category[1]);
    //   },
    // ),
    // CategoryContainer(
    //   category: category,
    //   title: category[2],
    //   icon: 'assets/icons/eye.png',
    //   press: () {
    //     Navigator.of(context)
    //         .pushNamed('/doc-info', arguments: category[2]);
    //   },
    // ),
    // CategoryContainer(
    //   category: category,
    //   title: category[3],
    //   icon: 'assets/icons/first-aid-kit.png',
    //   press: () {
    //     Navigator.of(context)
    //         .pushNamed('/doc-info', arguments: category[3]);
    //   },
    // ),
    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     color: Colors.cyan,
    //   ),
    //   padding: EdgeInsets.all(8),
    //   margin: EdgeInsets.all(10),
    //   child: TextButton(
    //     //padding: EdgeInsets.all(5),
    //     child: Text(
    //       category[0],
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     onPressed: () {
    //       Navigator.of(context)
    //           .pushNamed('/doc-info', arguments: category[0]);
    //     },
    //   ),
    // ),
    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     color: Colors.cyan,
    //   ),
    //   padding: EdgeInsets.all(8),
    //   margin: EdgeInsets.all(10),
    //   child: TextButton(
    //     //padding: EdgeInsets.all(5),
    //     child: Text(
    //       category[1],
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     onPressed: () {
    //       Navigator.of(context)
    //           .pushNamed('/doc-info', arguments: category[1]);
    //     },
    //   ),
    // ),
    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     color: Colors.cyan,
    //   ),
    //   padding: EdgeInsets.all(8),
    //   margin: EdgeInsets.all(10),
    //   child: TextButton(
    //     //padding: EdgeInsets.all(5),
    //     child: Text(
    //       category[2],
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     onPressed: () {
    //       Navigator.of(context)
    //           .pushNamed('/doc-info', arguments: category[2]);
    //     },
    //   ),
    // ),
    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     color: Colors.cyan,
    //   ),
    //   padding: EdgeInsets.all(8),
    //   margin: EdgeInsets.all(10),
    //   child: TextButton(
    //     //padding: EdgeInsets.all(5),
    //     child: Text(
    //       category[3],
    //       style: TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //     onPressed: () {
    //       Navigator.of(context)
    //           .pushNamed('/doc-info', arguments: category[3]);
    //     },
    //   ),
    // ),
    //     ],
    //   ),
    // );
  }
}
