import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 208, 208),
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: 
      Padding(
        padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  height: 300, width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 184, 218, 246),
                        ),
                        height: 100, width: 100,
                        child: Icon(Icons.person, size: 50,),
                      ),
                      SizedBox(height: 7,),
                      Text("Nama User",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text("namaemail@gmail.com",
                      style: TextStyle(color: const Color.fromARGB(255, 139, 138, 138), )),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(child: Container(
                             height: 30,color: const Color.fromARGB(255, 228, 226, 226),
                             padding: EdgeInsets.all(5),
                             child: 
                             Center(
                               child: Text("Informasi Akun",
                               style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey
                               ),),
                             ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),),
                           SizedBox(width: 5,),
                           Icon(Icons.logout, color: Colors.red,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}