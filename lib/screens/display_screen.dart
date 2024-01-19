import 'package:flutter/material.dart';
import 'package:shared_preference_task/util/color_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  late SharedPreferences logindata;
  String email = '';

  String? getEmail;
  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Email :$email',
              style: TextStyle(
                  color: ColorConstant.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff1E232C))),
                    onPressed: () async {
                      logindata = await SharedPreferences.getInstance();
                      // logindata.remove('email');
                      // email = '';
                      logindata.clear();

                      setState(() {});
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email') ?? '';
    });
  }
}
