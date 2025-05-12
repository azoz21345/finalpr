import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testfinal/homepage.dart';
import 'package:testfinal/sqldb.dart';
import 'package:testfinal/update.dart';
import 'package:testfinal/users.dart';
class ControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ControlPage();

}

class _ControlPage extends State<ControlPage> {
  final numbercontrol=TextEditingController();
  final codecontrol=TextEditingController();

  insertUser() async {
    if (numbercontrol.text.isNotEmpty && codecontrol.text.isNotEmpty) {

      final db = await SqlDb.instance.intialDb();
      final result = await db.query(
        'users',
        where: 'number = ? AND code = ?',
        whereArgs: [numbercontrol.text, codecontrol.text],
      );

      if (result.isNotEmpty) {

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("المستخدم موجود مسبقًا"),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.fixed,
        ));
        return;
      }


      var response = await SqlDb.instance.createUser(
        Users(number: numbercontrol.text, code: codecontrol.text),
      );

      if (response > 0) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("فشل في إضافة المستخدم"),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.fixed,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("الرجاء تعبئة جميع الحقول"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
      ));
    }
  }

  update()async{
    var user = await SqlDb.instance.loginUser(numbercontrol.text,codecontrol.text);
    if(user != null){
      if(!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePage(user: user)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("خطأ كلمة المرور او الكود"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
      )
      );
    }
  }
  delete() async {
    var user = await SqlDb.instance.loginUser(numbercontrol.text,codecontrol.text);
    if(user != null){
      if(!mounted) return;

        await SqlDb.instance.deleteUser(user);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePgae()));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("خطأ كلمة المرور او الكود"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
      )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Control Page"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(16),
          childAspectRatio: 1,
          shrinkWrap: true,
          children: <Widget>[
           TextField(
             controller: numbercontrol,
                decoration:
                InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Number"
                ),
              )
            ,
            TextField(
              controller: codecontrol,
                  decoration:
                  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "code"
                  ),
                )
           ,
            ElevatedButton(onPressed: (){
              insertUser();
            },style: ElevatedButton.styleFrom(fixedSize: Size(150, 60),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)), child: Text("creter")),

        ElevatedButton(onPressed: ()  {
          delete();
        },style: ElevatedButton.styleFrom(fixedSize: Size(150, 60),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)), child: Text("Delete ")),




            ElevatedButton(onPressed: (){
              update();
            },style: ElevatedButton.styleFrom(fixedSize: Size(150, 60),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)), child: Text("update")),


             ElevatedButton(onPressed: (){
               Navigator.pop(context);
             },style: ElevatedButton.styleFrom(fixedSize: Size(150, 60),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)), child: Text("back")),


          ],
        ),
      ),
    );
  }
}
