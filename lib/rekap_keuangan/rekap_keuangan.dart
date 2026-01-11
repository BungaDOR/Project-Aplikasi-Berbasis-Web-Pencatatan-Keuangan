import 'package:flutter/material.dart';

class RekapKeuangan extends StatefulWidget {
  const RekapKeuangan({super.key});

  @override
  State<RekapKeuangan> createState() => _RekapKeuanganState();
}

class _RekapKeuanganState extends State<RekapKeuangan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Rekap Keuangan"),
      backgroundColor: Colors.blue, 
      foregroundColor: Colors.white,
      ),

      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: Colors.green,),
                    SizedBox(width: 10,),
                    Text("Total Pemasukan",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                    Spacer(),
                    Text("Rp 12.500.000", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green,
                    ),),
                  ],
                ),
              ),
            ),
          ),

          //SizedBox(height: 3,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.paid, color: Colors.red,),
                    SizedBox(width: 10,),
                    Text("Total Pengeluaran",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                    Spacer(),
                    Text("Rp 12.500.000", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red,
                    ),),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rekap Per Kategori",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                color: Colors.black),
                ),
                Divider(),
                Text("Keuangan Anda", style: TextStyle(
                  fontSize: 10, 
                  fontWeight: FontWeight.w600, 
                  color: Colors.grey),
                ),
              ],
            ),
          ),

            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.business_center_sharp, color: Colors.blueGrey),
                    SizedBox(width: 10),
                    Text(
                      "Gaji",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      "Rp 19.000.000",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.food_bank, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        "Makanan",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Spacer(),
                      Text(
                        "Rp 1.500.000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),

          SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.orange),
                      SizedBox(width: 10),
                      Text(
                        "Belanja",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Spacer(),
                      Text(
                        "Rp 3.570.000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),

          SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_transportation_sharp, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        "Transportasi",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Spacer(),
                      Text(
                        "Rp 500.000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),

          SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.food_bank, color: Colors.red),
                      SizedBox(width: 10),
                      Text(
                        "Hiburan",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Spacer(),
                      Text(
                        "Rp 4.500.000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),

        ],
      ),
    );
  }
}