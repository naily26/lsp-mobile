import 'package:flutter/material.dart';
import 'package:my_final/data/img.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/register.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: Container(color: Color.fromARGB(255, 14, 111, 16))),
      body: Stack(
        children: <Widget>[
          Container(color: Color.fromARGB(255, 14, 111, 16), height: 220),
          Column(
            children: <Widget>[
              Container(height: 40),
              Container(

                child: 
                // Image.asset(
                //   Img.get('logo_small_round.png'),
                //   color: Colors.white,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                        'LSP Poliwangi',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: 24),
                      ),
                ),
                height: 80,
              ),
              Card(
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(6)),
                margin: EdgeInsets.all(25),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child :  Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(height: 25),
                      Text("SIGN IN", style: MyText.title(context)!.copyWith(
                          color: Colors.green[500], fontWeight: FontWeight.bold
                      )),
                      TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(labelText: "Email",
                          labelStyle: TextStyle(color: Colors.blueGrey[400]),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 2),
                          ),
                        ),
                      ),
                      Container(height: 25),
                      TextField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(labelText: "Password",
                          labelStyle: TextStyle(color: Colors.blueGrey[400]),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey[400]!, width: 2),
                          ),
                        ),
                      ),
                      Container(height: 25),
                      Container(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 14, 111, 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20)
                            ),
                          ),
                          child: Text("SUBMIT", style: TextStyle(color: Colors.white),),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(primary: Colors.transparent),
                          child: Text("Buat akun baru", style: TextStyle(color: Color.fromARGB(255, 14, 111, 16)),),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegiterPage()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              )
            ],
          )
        ],
      ),

    );
  }
}