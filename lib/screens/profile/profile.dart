import 'package:flutter/material.dart';
import 'package:my_app/screens/login/login_page.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/widgets/widget.dart';

class ProfilePage extends StatefulWidget {
  static const pageName = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String error = '';
  bool loading = false;
  final AuthenticationService _auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 47, 44, 61),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      children: const [
                        CircleAvatar(
                          backgroundImage: AssetImage("img/profile.png"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('MonNomDeCompte',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 30),
                  const ButtonProfile(
                    myColor: Color(0xFF666bd3),
                    myIcon: Icons.person,
                    myText: 'Mon Profile',
                    onTap: null,
                  ),
                  const SizedBox(height: 30),
                  const ButtonProfile(
                    myColor: Color(0xFF666bd3),
                    myIcon: Icons.calendar_month_rounded,
                    myText: 'Mes événements',
                    onTap: null,
                  ),
                  const SizedBox(height: 30),
                  ButtonProfile(
                    myColor: const Color(0xFF666bd3),
                    myIcon: Icons.login_outlined,
                    myText: 'Déconnexion',
                    onTap: () async {
                      try {
                        setState(() {
                          loading = true;
                          error = '';
                        });
                        await _auth.signOut();
                        //Déconnexion de l'utilisateur
                        setState(() {
                          loading = false;
                          Navigator.of(context).pushNamed(LoginPage.pageName);
                          error = '';
                        });
                      } catch (e) {
                        setState(() {
                          loading = false;
                          error = e.toString();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}

class ButtonProfile extends StatelessWidget {
  final Color myColor; // = const Color(0xFF666bd3);
  final IconData myIcon;
  final String myText;
  final void Function()? onTap;
  const ButtonProfile({
    Key? key,
    required this.myColor,
    required this.myIcon,
    required this.myText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFF5F6F9),
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        onPressed: onTap,
        child: Row(
          children: [
            Icon(myIcon, color: myColor),
            const SizedBox(width: 20),
            Expanded(
                child: Text(myText,
                    style: TextStyle(color: myColor, fontSize: 16))),
            Icon(Icons.arrow_forward_ios, color: myColor),
          ],
        ));
  }
}
