import 'package:flutter/material.dart';

class Col extends StatelessWidget {
  static final String id='custom_wid';
  final Color color;
  final double pi=3.14;
  final double height;
  final double width;
  final double width1;
  final double width2;
  final double width3;
  final double sizedB;
  Col({this.color,this.height,this.width,this.width1,this.width2,this.width3,this.sizedB});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Transform.translate(
          offset:Offset(12,0),
          child: Transform(
            transform: Matrix4.rotationZ(pi/20),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
          ),
        ),
        SizedBox(height: sizedB+5,),
        Container(
          width: width1,
          height: height,
          decoration: BoxDecoration(
              color: color,
              borderRadius:BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
          ),
        ),
        SizedBox(height: sizedB,),
        Container(
          width:width2,
          height:height,
          decoration: BoxDecoration(
              color: color,
              borderRadius:BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
          ),
        ),
        SizedBox(height: sizedB,),
        Container(
          width: width3,
          height: height,
          decoration: BoxDecoration(
              color: color,
              borderRadius:BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
          ),
        ),
      ],
    );
  }
}
