import 'package:flutter/material.dart';
import 'package:flutter_app/pages/sign_in.dart';
import 'package:flutter_app/pages/transactions_page.dart';
import 'package:flutter_app/providers/data.dart';
import 'package:flutter_app/providers/transaction_provider.dart';
import 'package:flutter_app/utilities/colors.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/transaction_history.dart';
import 'package:flutter_app/utilities/toaster.dart';
import 'package:flutter_app/widgets/circle_icon_button.dart';
import 'package:material_color_generator/material_color_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:  '/',
      routes: {
        '/': (context) => const AppLayout(),
        '/sign-in': (context) => const SignIn(),
        '/settings': (context) => const SettingsPage(),
        '/transactions':(context)=> const TransactionsPage(),
      },
      title: 'Budget App',
      theme: ThemeData(
          primaryColor: const Color(0xff102e4a),
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch:
                      generateMaterialColor(color: const Color(0xff102e4a)))
              .copyWith(secondary: const Color(0xff35d4a5)),
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            headline4: TextStyle(fontWeight: FontWeight.w200),
          ),
          splashColor: const Color(0xff102e4a)),
    );
  }
}

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with Toaster {
  int _selectedIndex = 0;
  final _pageViewController = PageController();

  void _onItemTapped(int index) {
    _pageViewController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.bounceOut);
  }

  List<Transaction> expenditures = [];

  void expenditureListener(List<Transaction> data) {
    setState(() {
      expenditures = data;
    });


  }


  int availableBalance = 0;


  String username = "";

  void setUsername() async {
    String name = await getUserName();
    setState(() {
      username = name;
    });
  }

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    setUsername();
    init();
  }


  Future<void> refresh() async {
    try {
      await getTransactions(expenditureListener);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  bool loading = true;

  void init() async {
    setState(() {
      loading = true;
    });
    try {
      await refresh();
      listenForTransactions(expenditureListener);
    } catch (e) {
      showToast(
          'Failed to load data. Please restart application. \n ${e.toString()}');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        layoutBuilder: (
          Widget topChild,
          Key topChildKey,
          Widget bottomChild,
          Key bottomChildKey,
        ) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'App',
                style: TextStyle(
                  color: Color(prussianBlue), // 3
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleIconButton(
                    onClick: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    icon: Icons.settings,
                  ),
                )
              ],
            ),
            body: Stack(
              children: [
                bottomChild,
                Positioned(child: topChild)
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                    activeIcon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.summarize_outlined),
                    label: 'History',
                    activeIcon: Icon(Icons.summarize)),

              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(prussianBlue),
              unselectedItemColor: const Color(prussianBlue),
              onTap: _onItemTapped,
              showSelectedLabels: true,
              showUnselectedLabels: false,
            ),

          );
        },
        firstChild: PageView(
          controller: _pageViewController,
          children: <Widget>[
            Home(
              availableBalance: availableBalance,
              transactions: expenditures,
              username: username,
              refresh: refresh,
            ),
            TransactionHistory(
              expenditures: expenditures,
              refresh: refresh,
              showToast: showToast,
            ),

          ],
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        secondChild: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        crossFadeState:
            loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(seconds: 1));
  }
}
