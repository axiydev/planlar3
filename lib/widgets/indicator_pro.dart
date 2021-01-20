import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planlar/constants/constants.dart';
class ProIndicator extends StatefulWidget {
  static const String id='indicator_pro';
  @override
  _ProIndicatorState createState() => _ProIndicatorState();
}
//#my custom indicator
class _ProIndicatorState extends State<ProIndicator> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;
  Animation _animation1;
  @override
  void initState(){
    super.initState();
    _controller=AnimationController(vsync:this,duration:Duration(milliseconds: 500));
    _animation=Tween<Size>(begin: Size(0,0),end:Size(40,40)).animate(CurvedAnimation(parent: _controller,curve: Curves.easeIn))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _controller.reverse();
      }
    });
    _animation1=Tween<Size>(begin: Size(40,40),end:Size(0,0)).animate(CurvedAnimation(parent: _controller,curve: Curves.ease))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _controller.reverse();
      }
    });
    _controller.repeat();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Container(
      height:size.height,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 10,
            child: _indicatorBubble(isFirst: true),
          ),
          Spacer(flex: 1,),
          Flexible(
            flex: 10,
            child: _indicatorBubble(isFirst: false),
          ),
        ],
      ),
    );
  }
  Widget _indicatorBubble({isFirst}){
    return AnimatedBuilder(
      animation:isFirst?_animation:_animation1,
      builder:(BuildContext context,ch)=>Container(
        height:isFirst?_animation.value.height:_animation1.value.height,
        width:isFirst?_animation.value.width:_animation1.value.width,
        margin: EdgeInsets.only(right: 10),
        decoration:BoxDecoration(
          shape:BoxShape.circle,
          color: greenColorWidget,
        ),
      ),
    );
  }
}

