import 'package:flutter/material.dart';
import 'package:project_akhir_uas/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/profil_service.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String _token = '';
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
    _loadTokenAndProfile();
  }

  // Ambil token dari SharedPreferences lalu panggil API profil
  void _loadTokenAndProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    setState(() {
      _token = token;
      _userFuture = ProfilService.getProfile(_token);
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // hapus token saat logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat data'));
          }

          final user = snapshot.data ?? {};

          return Padding(
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
                        color: Color(0xFFB8DAF6),
                      ),
                      child: Icon(Icons.person, size: 60),
                    ),

                    SizedBox(height: 10),

                    Text(
                      user['name'] ?? 'Nama User',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      user['email'] ?? 'namaemail@gmail.com',
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(height: 20),

                    // ===== Informasi Akun =====
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 30,
                            color: Colors.grey[200],
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "Informasi Akun",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.grey[600]),
                          SizedBox(width: 8),
                          Text("Username"),
                          Spacer(),
                          Text(user['name'] ?? 'NamaUser',
                              style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),

                    SizedBox(height: 4),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Icon(Icons.email, color: Colors.grey[600]),
                          SizedBox(width: 8),
                          Text("Email"),
                          Spacer(),
                          Text(user['email'] ?? 'namaemail@gmail.com',
                              style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),

                    SizedBox(height: 4),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
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

                    SizedBox(height: 20),

                    // ===== Tentang Aplikasi =====
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 30,
                            color: Colors.grey[200],
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "Tentang Aplikasi",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Icon(Icons.sticky_note_2, color: Colors.grey[600]),
                          SizedBox(width: 8),
                          Text("Aplikasi Pencatatan Keuangan"),
                        ],
                      ),
                    ),

                    SizedBox(height: 4),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Icon(Icons.settings, color: Colors.grey[600]),
                          SizedBox(width: 8),
                          Text("Versi"),
                          SizedBox(width: 5),
                          Text("1.0.0")
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Divider(),

                    // Tombol Logout
                    TextButton.icon(
                      onPressed: _logout,
                      icon: Icon(Icons.logout, color: Colors.red),
                      label: Text(
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
          );
        },
      ),
    );
  }
}
