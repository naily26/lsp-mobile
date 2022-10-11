import 'package:flutter/material.dart';
import 'package:my_final/data/my_colors.dart';
import 'package:my_final/widget/my_text.dart';
import 'package:my_final/pages/master.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitched1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_10,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180.0,
              floating: false, pinned: true,
              backgroundColor: Color.fromARGB(255, 14, 111, 16),
              flexibleSpace: FlexibleSpaceBar(),
              bottom: PreferredSize(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                    alignment: Alignment.bottomLeft,
                    constraints: BoxConstraints.expand(height: 50),
                    child: Text("Naily Ikmalul Insiyah", style: MyText.headline(context)!.copyWith(color: Colors.white)),
                  ),
                  preferredSize: Size.fromHeight(50)
              ),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (String value){},
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "Settings",
                      child: GestureDetector(child: Text("Log Out"), 
                       onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MyMaster()),
                                    );
                                  },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0),),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Bio", style: MyText.subhead(context)!.copyWith(color: MyColors.primaryDark, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("+61883762938", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Phone", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("nailyyy", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("Username", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("naily@gmail.com", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                              Text("E-mail", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 10),
              // Card(
              //   margin: EdgeInsets.all(0),
              //   shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0),),
              //   clipBehavior: Clip.antiAliasWithSaveLayer,
              //   elevation: 1,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text("Info", style: MyText.subhead(context)!.copyWith(color: MyColors.primaryDark, fontWeight: FontWeight.bold)),
              //           ],
              //         ),
              //       ),
              //       Container(height: 10),
              //       InkWell(
              //         highlightColor: Colors.grey.withOpacity(0.1),
              //         splashColor: Colors.grey.withOpacity(0.1),
              //         onTap: () => (){},
              //         child: Container(
              //             width: double.infinity,
              //             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              //             child: Text("Notification and Sound", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
              //         ),
              //       ),
              //       Divider(height: 0),
              //       InkWell(
              //         highlightColor: Colors.grey.withOpacity(0.1),
              //         splashColor: Colors.grey.withOpacity(0.1),
              //         onTap: () => (){},
              //         child: Container(
              //           width: double.infinity,
              //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              //           child: Text("Privacy and Security", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
              //         ),
              //       ),
              //       Divider(height: 0),
              //       InkWell(
              //         highlightColor: Colors.grey.withOpacity(0.1),
              //         splashColor: Colors.grey.withOpacity(0.1),
              //         onTap: () => (){},
              //         child: Container(
              //           width: double.infinity,
              //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              //           child: Text("Data and Storage", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
              //         ),
              //       ),
              //       Divider(height: 0),
              //       InkWell(
              //         highlightColor: Colors.grey.withOpacity(0.1),
              //         splashColor: Colors.grey.withOpacity(0.1),
              //         onTap: () => (){},
              //         child: Container(
              //             width: double.infinity,
              //             padding: EdgeInsets.symmetric(horizontal: 15),
              //             child: Row(
              //               children: <Widget>[
              //                 Text("Enable Animation", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
              //                 Spacer(),
              //                 Switch(
              //                   value: isSwitched1,
              //                   onChanged: (value) {setState(() { isSwitched1 = value; });},
              //                   activeColor: MyColors.primary,
              //                   inactiveThumbColor: Colors.grey,
              //                 )
              //               ],
              //             )
              //         ),
              //       ),
              //       Divider(height: 0),
              //       InkWell(
              //         highlightColor: Colors.grey.withOpacity(0.1),
              //         splashColor: Colors.grey.withOpacity(0.1),
              //         onTap: () => (){},
              //         child: Container(
              //             width: double.infinity,
              //             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              //             child: Row(
              //               children: <Widget>[
              //                 Text("Theme", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
              //                 Spacer(),
              //                 Text("Default", style: MyText.subhead(context)!.copyWith(color: MyColors.primary)),
              //               ],
              //             )
              //         ),
              //       ),
              //       Divider(height: 0),
              //       InkWell(
              //         highlightColor: Colors.grey.withOpacity(0.1),
              //         splashColor: Colors.grey.withOpacity(0.1),
              //         onTap: () => (){},
              //         child: Container(
              //             width: double.infinity,
              //             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              //             child: Row(
              //               children: <Widget>[
              //                 Text("Language", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
              //                 Spacer(),
              //                 Text("English", style: MyText.subhead(context)!.copyWith(color: MyColors.primary)),
              //               ],
              //             )
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(height: 10),
              Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0),),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Support", style: MyText.subhead(context)!.copyWith(color: MyColors.primaryDark, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("Ask a Question", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("F A Q", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                    Divider(height: 0),
                    InkWell(
                      highlightColor: Colors.grey.withOpacity(0.1),
                      splashColor: Colors.grey.withOpacity(0.1),
                      onTap: () => (){},
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text("Privacy Policy", style: MyText.medium(context).copyWith(color: MyColors.grey_80)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 15),
              Text("LSP mobile 1.0.0", style: MyText.caption(context)!.copyWith(color: MyColors.grey_40)),
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}