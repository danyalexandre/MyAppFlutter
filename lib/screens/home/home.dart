import 'package:flutter/material.dart';
import 'package:my_app/screens/formulaire/ajouterEvenement.dart';
import 'package:my_app/screens/login/login_page.dart';
import 'package:my_app/screens/accueil/accueil.dart';
import 'package:my_app/screens/formulaire/ajouterEvenement.dart';
import 'package:my_app/screens/profile/profile.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/widgets/widget.dart';

class MyHomePage extends StatefulWidget {
  static const pageName = "/home";
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [AccueilPage(), AddEventPage(), ProfilePage()];
  final AuthenticationService _auth = AuthenticationService();
  String error = '';
  bool loading = false;
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff191720),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Créer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'Profile',
          )
        ],
      ),
    );
    /*Scaffold(
            body: Container(
              color: Colors.white,
              child: MyButton(
                  buttonName: 'Déconnexion',
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
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                        error = '';
                      });
                    } catch (e) {
                      setState(() {
                        loading = false;
                        error = e.toString();
                      });
                    }
                  },
                  bgColor: const Color(0xFF666bd3),
                  textColor: Colors.white),
            ),*/
  }
}
