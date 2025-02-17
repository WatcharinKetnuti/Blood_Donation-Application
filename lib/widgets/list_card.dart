import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget{
  final List list ;

  const ListCard({super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              leading: Icon(
                Icons.calendar_today_outlined,
                color: Colors.black54,
                size: 30.0,
              ),
              title: Text(
                "${list[index]['location_name']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                    " ${list[index].location_name} \n"
                    " ${list[index].location_name} \n",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black54,
                ),
              ),
              trailing: Text(
                "จำนวนที่รับ: ${list[index].location_name} คน\n"
                    "หมู่เลือด: ${list[index].location_name} \n",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.right,
              ),
              onTap: () {
                //Navigator.pushNamed(context, '/detail');
              },
            ),
          );
        }
    );
  }
}