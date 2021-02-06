import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//chart widget
class ChartDart extends StatelessWidget {
  static const String id='chart_dart';
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Container(
      height:size.height*0.4,
      width:size.width,
      child:Stack(
        children: [
          Column(
            children: [
              Flexible(child: Align(alignment: Alignment.bottomCenter,child: Divider(thickness: 1,color: Colors.grey[200],indent: size.width*0.03,endIndent:size.width*0.13,),)),
              Flexible(child: Align(alignment: Alignment.bottomCenter,child: Divider(thickness: 1,color: Colors.grey[200],indent: size.width*0.03,endIndent:size.width*0.13,),)),
              Flexible(child: Align(alignment: Alignment.bottomCenter,child: Divider(thickness: 1,color: Colors.grey[200],indent: size.width*0.03,endIndent:size.width*0.13,),)),
              Flexible(child: Align(alignment: Alignment.bottomCenter,child: Divider(thickness: 1,color: Colors.grey[200],indent: size.width*0.03,endIndent:size.width*0.13,),)),
              Flexible(child:Container()),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _pro(context,0.07,Color.fromRGBO(245, 220, 120, 1),'Mo'),
              ),
              Expanded(
                  child: _pro(context, 0.2, Color.fromRGBO(239, 233, 218,1), "Tu")
              ),
              Expanded(
                child: _pro(context, 0.33,Color.fromRGBO(19, 72, 82, 1), 'We'),
              ),
              Expanded(
                child:_pro(context, 0.099, Color.fromRGBO(240,238,217,1), 'Th'),
              ),
              Expanded(
                child:_pro(context, 0.38, Color.fromRGBO(188, 134, 90,1), 'Fr'),
              ),
              Expanded(
                child: _pro(context, 0.25, Color.fromRGBO(247, 221, 112,1), "Sa"),
              ),
              Expanded(
                child: _pro(context, 0.17, Color.fromRGBO(14, 78, 88,1), 'Su'),
              ),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 10,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(child:_wdg('20')),
                                Flexible(child:_wdg('15')),
                                Flexible(child:_wdg('10')),
                                Flexible(child:_wdg('5')),
                              ],
                            )
                        ),
                        Flexible(
                          flex: 2,
                          child:Container(
                            child: Center(
                              child:Container(),
                            ),
                          ),)
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
  Widget _pro(BuildContext context,num s,Color color,String title){
    final Size size=MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 10,
            child:Container(
              margin: EdgeInsets.only(top: size.width*s,left: 5,right: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
              ),
            ),),
          Flexible(
            flex: 2,
            child:Container(
              child: Center(
                child:Text(title,style: GoogleFonts.poppins(fontSize:12,fontWeight: FontWeight.w500,color: Colors.grey[700]),),
              ),
            ),)
        ],
      ),
    );
  }

  Widget _wdg(String title){
    return  Container(
      height: double.infinity,
      width: double.infinity,
      child: Align(
        alignment: Alignment.bottomCenter,
        child:Text(title,style: GoogleFonts.poppins(fontSize:15,fontWeight: FontWeight.w500,color: Colors.grey[700]),),
      ),
    );
  }
}
