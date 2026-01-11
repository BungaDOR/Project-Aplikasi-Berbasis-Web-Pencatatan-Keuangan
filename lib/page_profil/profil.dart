import 'package:flutter/material.dart';
import 'package:project_akhir_uas/authCoba/register.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 184, 218, 246),
                  ),
                  child: Icon(Icons.person, size: 60),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Nama User",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "namaemail@gmail.com",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [ Expanded(child: 
                    Container( height: 30,color: Colors.grey[200], 
                      padding: EdgeInsets.all(5), 
                        child: Text("Informasi Akun", 
                        style: TextStyle( 
                          fontWeight: FontWeight.w600, color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                Padding(
                  padding:EdgeInsetsGeometry.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey[600]),
                       SizedBox(width: 8),
                       Text("Username"),
                       Spacer(),
                      Text("NamaUser", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),

                SizedBox(height: 4,),

                Padding(
                  padding:EdgeInsetsGeometry.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Icon(Icons.email, color: Colors.grey[600]),
                       SizedBox(width: 8),
                       Text("Email"),
                       Spacer(),
                      Text("namaemail@gmail.com", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),

                SizedBox(height: 4,),

                Padding(
                  padding:EdgeInsetsGeometry.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.grey[600]),
                       SizedBox(width: 8),
                       Text("Status"),
                       Spacer(),
                      Text("Aktif", style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                Row(
                  children: [ Expanded(child: 
                    Container( height: 30,color: Colors.grey[200], 
                      padding: EdgeInsets.all(5), 
                        child: Text("Tentang Aplikasi", 
                        style: TextStyle( 
                          fontWeight: FontWeight.w600, color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                Padding(
                  padding:EdgeInsetsGeometry.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Icon(Icons.sticky_note_2, color: Colors.grey[600]),
                       SizedBox(width: 8),
                       Text("Aplikasi Pencatatan Keuangan"),
                    ],
                  ),
                ),

                SizedBox(height: 4,),

                Padding(
                  padding:EdgeInsetsGeometry.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.grey[600]),
                       SizedBox(width: 8),
                       Text("Versi"),
                       SizedBox(width: 5,),
                       Text("1.0.0")
                    ],
                  ),
                ),

                SizedBox(height: 4,),

                 SizedBox(height: 20),
                 Divider(),

               // Tombol Logout
                TextButton.icon(
                  onPressed: () {
                    // Kembali ke halaman Register
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Logout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}