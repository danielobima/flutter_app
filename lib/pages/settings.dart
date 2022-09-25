import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/data.dart';
import 'package:flutter_app/widgets/circle_icon_button.dart';
import '../utilities/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final bool showSettings = false;
  String username = "";
  void setUsername()async{
    String name = await getUserName();
    setState(() {
      username = name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUsername();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleIconButton(
                          onClick: () {
                            Navigator.pop(context);
                          },
                          icon: Icons.arrow_back),
                      CircleIconButton(
                          onClick: () async{
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(context,'/sign-in');
                          },
                          icon: Icons.logout)

                    ],
                  ),
                ),
              ),
              const Text(
                'Settings',
                style: TextStyle(
                    fontSize: 22,
                    color: Color(prussianBlue),
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            child: const CircleAvatar(
                              maxRadius: 80,
                              backgroundImage:
                                  AssetImage('assets/images/daniel.JPG'),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 6,
                                    color: Colors.black.withOpacity(0.16),
                                    spreadRadius: 3)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Expanded(
                          flex: 2,
                          child: Text(
                           username,
                           style: const TextStyle(
                               fontSize: 25, color: Color(prussianBlue)),
                              ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: showSettings? ListView(
                      children: [
                        ListTile(
                          title: const Text(
                            'Wallets',
                            style: TextStyle(
                                color: Color(prussianBlue),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          leading: Container(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                              ),
                            ),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(mayaBlue)
                            ),
                          ),

                        ),
                        const Divider(height: 5,),
                        ListTile(
                          title: const Text(
                            'History',
                            style: TextStyle(
                                color: Color(prussianBlue),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          leading: Container(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.history_outlined,
                                color: Colors.white,
                              ),
                            ),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(mayaBlue)
                            ),
                          ),

                        ),
                        const Divider(height: 5,),
                        ListTile(
                          title: const Text(
                            'Currency',
                            style: TextStyle(
                                color: Color(prussianBlue),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          leading: Container(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                              ),
                            ),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(mayaBlue)
                            ),
                          ),

                        ),
                        const Divider(height: 5,),
                      ],
                    ):Container(),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
