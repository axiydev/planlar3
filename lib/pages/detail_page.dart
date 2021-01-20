import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planlar/models/post_model.dart';
import 'package:planlar/pages/daily_page.dart';
import 'package:planlar/services/prefs_service.dart';
import 'package:planlar/services/rtdb_service.dart';
import 'package:planlar/services/storage_service.dart';
import 'package:planlar/widgets/indicator_pro.dart';
class DetailPage extends StatefulWidget {
  static const String id="detail_page";
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading=false;
  var titleController=new TextEditingController();
  var contentController=new TextEditingController();
  File _image;
  var picker=ImagePicker();
  Future getImage()async{
    final pickedFile=await picker.getImage(source:ImageSource.gallery);
    setState(() {
      if(pickedFile!=null){
        _image=File(pickedFile.path);
      }else{
        print('No image selected');
      }
    });
  }
  _apiUploadImage(title,content){
    setState(() {
      isLoading=true;
    });
  StorageService.uploadImage(_image).then((img_url) =>_apiAddPost(title, content,img_url));
  }
  _addPost()async{
    var title=titleController.text.trim();
    var content=contentController.text.trim();
    if(_image==null)return;
    _apiUploadImage(title,content);
  }
  _apiAddPost(String title,String content,img)async{
    var id =await Prefs.loadUserId();
    var post =new Post(userId:id,title: title,subtitle: content,img: img);
    await RTDBService.addPost(post).then((value){
      _respAddPost();
    }).catchError((err)=>print(err));
  }
  _respAddPost(){
    setState(() {
      isLoading=false;
    });
    Navigator.of(context).pop({'data':'done'});
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        bottomOpacity: 0.0,
        brightness: Brightness.light,
        backgroundColor:Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context,DailyPage.id);
          },
          icon: FaIcon(FontAwesomeIcons.longArrowAltLeft),
          color: Colors.grey,
        ),
        actions: [
          IconButton(
            icon:FaIcon(FontAwesomeIcons.search),
            onPressed: (){},
            color: Colors.grey,
          ),
          IconButton(
            icon:FaIcon(FontAwesomeIcons.bookmark),
            onPressed: (){},
            color: Colors.grey,
          ),
          SizedBox(width: 15,),
        ],
      ),
      body:Stack(
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                      height: size.width*0.7,
                      width: size.width*0.7,
                      padding: EdgeInsets.all(20),
                      margin:EdgeInsets.only(bottom: 20,top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:_image!=null?Image.file(_image,fit: BoxFit.cover,):Image.asset('assets/images/barg1.png',fit: BoxFit.cover,),
                      ),
                    ),
                    onTap: getImage,
                  ),
                  _field(context,'Title',titleController),
                  _field(context,'Content',contentController),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: size.width*0.15,
                    child:FlatButton(
                      onPressed: (){
                        _addPost();
                      },
                      child:Text('Add',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color:Theme.of(context).textTheme.button.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(isLoading)Center(
            child:ProIndicator()
          ),
        ],
      ),
    );
  }
  Widget _field(BuildContext context,title,controller){
    final Size size =MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: size.width*0.15,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2,color:Theme.of(context).textTheme.button.color),
        ),
        child:Center(
          child: TextField(
            controller: controller,
            style:GoogleFonts.poppins(fontSize: 20,color: Colors.grey[700],fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: title,
              hintStyle: GoogleFonts.poppins(fontSize: 20,color: Colors.grey[700],fontWeight: FontWeight.w500),
              border:InputBorder.none,
            ),
          ),
        )
    );
  }
}
