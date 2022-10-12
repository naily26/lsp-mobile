import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:my_final/models/dokumentasi.dart';
import 'package:my_final/models/slider.dart';
import 'package:my_final/pages/skema.dart';
import 'package:my_final/pages/tuk.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _data = [];
  final String _tokenAuth = '';

  // Future Get Data
  Future _getAllData() async {
    try {
      var url = Uri.parse('https://lsp-api.000webhostapp.com/api/get_data_kampus');
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ' + _tokenAuth},
      );
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body)['result'];
        });
      } else {
        print('error');
      }
    } on SocketException {
      print('no internet');
    } on HttpException {
      print('error');
    } on FormatException {
      print('error');
    }
  }

_getData() {
  var uri =_data[0]['file_alur_Sertifikasi'];
  return uri;
}

final Uri _url = Uri.parse('https://flutter.dev');
 Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LSP'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          SizedBox(
                            height: 250,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return new Image.asset(
                                 slidermodels[index].image.toString(),
                                  fit: BoxFit.fill,
                                );
                              },
                              itemCount: slidermodels.length,
                              pagination: new SwiperPagination(),
                              // control: new SwiperControl(),
                              autoplay: true,
                              ),
                           ),
                        ],
                      ),
                       Container(
                        margin: EdgeInsets.only(top: 40, bottom: 10, right: 15, left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Informasi untuk anda', style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Skema()),
                                    );
                                  },
                                  child: Container(
                                    width: ((MediaQuery.of(context).size.width)-30)/3,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only( bottom: 10),
                                          child: Image.asset('assets/images/calendar.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Text('Daftar uji skema',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                 GestureDetector(
                                  //  onTap: () async {
                                  //                         String url = _data[0]['file_alur_sertifikasi'];
                                  //                         Uri myUri = Uri.parse(url);
                                  //                         var urllaunchable = await launchUrl(myUri); //canLaunch is from url_launcher package
                                  //                         if(urllaunchable){
                                  //                             await launchUrl(myUri); //launch is from url_launcher package to launch URL
                                  //                         }else{
                                  //                           print("URL can't be launched.");
                                  //                         }
                                  //                       },
                                   child: Container(
                                     width: ((MediaQuery.of(context).size.width)-30)/3,
                                     child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Image.asset('assets/images/checklist.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Text('Alur sertifikasi',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300
                                          ),
                                        )
                                      ],
                                ),
                                   ),
                                 ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const TUK()),
                                      );
                                    },
                                    child: Container(
                                     width: ((MediaQuery.of(context).size.width)-30)/3,
                                     child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:20, bottom: 10),
                                          child: Image.asset('assets/images/map.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Text('Tempat uji\nkomptensi',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300
                                          ),
                                        )
                                      ],
                                ),
                                 ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                       )   
                    ],
                  ),
                  Positioned(
                    top: 225,
                    left: ((MediaQuery.of(context).size.width)-((MediaQuery.of(context).size.width)-15)),
                    right: ((MediaQuery.of(context).size.width)-((MediaQuery.of(context).size.width)-15)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Skema()),
                        );
                      },
                      child: Container(
                        height:54,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 14, 111, 16),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                        child: Center(
                          child: Text(
                            'Daftar uji skema sekarang >',
                            style: TextStyle(color: Color.fromARGB(255, 14, 111, 16),
                            fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
                child: Container(
                decoration: 
                const BoxDecoration(
                  color: Color.fromARGB(121, 221, 218, 218),
                ),
              ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 10, right: 15, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sukses, Kompeten, dan Dipercaya',
                    textAlign: TextAlign.start, 
                      style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset('assets/banner/banner11.jpg')
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 35, left: 15),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '11 orang \nAsesi lolos sertifikasi',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 4,
                child: Container(
                decoration: 
                const BoxDecoration(
                  color: Color.fromARGB(121, 221, 218, 218),
                ),
              ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 10, right: 15, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dokumentasi kegiatan',
                    textAlign: TextAlign.start, 
                      style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              ),
                    ),
                                   
                  ],
                ),
              )
            ],
          ),
          
        ),
      )
    );
  }
}