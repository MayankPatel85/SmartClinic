import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CategoryContainer extends StatelessWidget {
  final String title;
  final Function press;
  final String icon;

  const CategoryContainer({
    Key key,
    @required this.category,
    this.title,
    this.press,
    this.icon,
  }) : super(key: key);

  final List<String> category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFa8d8ea),
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SvgPicture.asset(
                icon,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        //onPressed: press,
        // onPressed: () {
        //   Navigator.of(context).pushNamed('/doc-info', arguments: category[0]);
        // },
      ),
    );
  }
}
