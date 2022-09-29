import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_app/auth/auth_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/widgets/reuseble_text.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
           Container(
             padding:const EdgeInsets.only(top: 26,bottom: 12),
             child: Column(
               children: [
                 Container(
                   height: 130,
                   width: 130,
                   child: CircleAvatar(
                     backgroundImage: NetworkImage(
                       sharedPreferences!.getString("photoUrl")!,
                     ),
                   ),
                 ),
                 const SizedBox(height: 12,),
                 ReusebleText(text: sharedPreferences!.getString("name")!,color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold,)
               ],
             ),
           ),
          Container(
            padding:const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                 const Divider(
                   height: 10,
                   color: Colors.grey,
                   thickness: 2,
                 ),

                ListTile(
                  leading:const Icon(Icons.home,color: Colors.grey,),
                  title: ReusebleText(text:"Home",color: Colors.grey,),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.reorder,color: Colors.grey,),
                  title: ReusebleText(text:"My Orders",color: Colors.grey,),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.picture_in_picture_alt_outlined,color: Colors.grey,),
                  title: ReusebleText(text:"Not yet receive order",color: Colors.grey,),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.access_time,color: Colors.grey,),
                  title: ReusebleText(text:"History",color: Colors.grey,),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.search,color: Colors.grey,),
                  title: ReusebleText(text:"Search",color: Colors.grey,),
                  onTap: (){

                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTile(
                  leading:const Icon(Icons.exit_to_app,color: Colors.grey,),
                  title: ReusebleText(text:"Sign Out",color: Colors.grey,),
                  onTap: (){
                     FirebaseAuth.instance.signOut();
                     Navigator.push(context, MaterialPageRoute(builder: (c)=>const SplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
