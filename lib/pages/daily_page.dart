import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planlar/models/post_model.dart';
import 'package:planlar/pages/home_page.dart';
import 'package:planlar/pages/detail_page.dart';
import 'package:planlar/services/prefs_service.dart';
import 'package:planlar/services/rtdb_service.dart';
import 'package:planlar/widgets/indicator_pro.dart';

class DailyPage extends StatefulWidget {
  static const String id="daily_page";
  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  final Color _color=Color.fromRGBO(253, 243, 233,1);
  List<Post> lt=new List();
  bool isLoading=true;
  @override
  void initState(){
    super.initState();
    _apiGetPost();
  }
  Future _openDetail()async{
    var result=await Navigator.of(context).push(new MaterialPageRoute(builder:(context){
      return new DetailPage();
    }));
    if(result!=null && result.containsKey('data')){
      _apiGetPost();
    }
  }
  _apiGetPost()async{
    setState(() {
      isLoading=true;
    });
    var id=await Prefs.loadUserId();
    RTDBService.getPost(id).then((posts){
      _loadPost(posts);
    }).catchError((err)=>print(err));
  }
  _loadPost(posts){
    setState(() {
      isLoading=false;
      lt=posts.toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading:IconButton(
          icon: FaIcon(FontAwesomeIcons.longArrowAltLeft),
          onPressed: (){
            Navigator.pushReplacementNamed(context,HomeScreen.id);
          },
        ),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.plusCircle),
            onPressed:()async{
             await _openDetail();
            },
          ),
          IconButton(
            icon:FaIcon(FontAwesomeIcons.search),
            onPressed: (){},
          ),
          IconButton(
            icon:FaIcon(FontAwesomeIcons.bookmark),
            onPressed: (){},
          ),
          SizedBox(width: 15,),
        ],
        elevation: 0.0,
      ),
      body:SafeArea(
        child:Stack(
          children: [
            Container(
              height: size.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child:Container(
                      width: double.infinity,
                      child:Text('Daily practises',style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child:Container(
                      child: SingleChildScrollView(
                        child:ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: lt.length,
                            itemBuilder:(ctx,index){
                              return _posts(context,lt[index]);
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if(isLoading)Center(
              child: ProIndicator(),
            )
          ],
        ),
      ),
    );
  }
  Widget _posts(BuildContext context,Post post){
    final Size size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 20,),
      width: double.infinity,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child:Container(
              height:size.width*0.32,
              padding: EdgeInsets.all(1),
              width:double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.5,color: Colors.grey),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:post.img!=null?Image.network(post.img,fit: BoxFit.cover,):Image.asset('assets/images/barg1.png',fit: BoxFit.cover)
              ),
            ),
          ),
          Spacer(flex: 1,),
          Expanded(
            flex: 11,
            child:Container(
              height: size.width*0.3,
              width: double.infinity,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex:3,
                    child:Container(
                      child:Text(post.title,style: GoogleFonts.poppins(fontSize: 23,fontWeight: FontWeight.w600),),
                    ),),
                  Spacer(flex: 1,),
                  Expanded(
                    flex:5,
                    child: Container(
                      child:Text(post.subtitle,style: GoogleFonts.poppins(color:Colors.grey[600],fontSize: 15,fontWeight: FontWeight.w500,height: 1)),
                    ),),
                  Expanded(
                    flex:3,
                    child: Container(
                      child:InkWell(
                        onTap: (){},
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Start now',style: GoogleFonts.poppins(color:Color.fromRGBO(8,31, 34,1),fontSize: 16,fontWeight: FontWeight.w500)),
                            SizedBox(width: 5,),
                            FaIcon(FontAwesomeIcons.chevronRight,size: 16,),
                          ],
                        ),
                      ),
                    ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
