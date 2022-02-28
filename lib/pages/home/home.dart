import 'dart:async';

import 'package:bankx/pages/screens.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final cardList = [
    {
      'accountType': 'Monto Prestado',
      'accountNumber': '0325 2365 1478',
      'balance': '100,899',
    },
    {
      'accountType': 'Monto Pagado',
      'accountNumber': '5984 4562 3258',
      'balance': '20,000',
    },
  ];
  bool scaled = false;
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 80),
      () => setState(() {
        scaled = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF1F3),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 5.0,
        centerTitle: true,
        title: Image.asset('assets/logo.png', fit: BoxFit.cover),
        toolbarHeight: 50, // default is 56
        toolbarOpacity: 0.5,
        shape: StadiumBorder(),
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 10,
            ),
            Image.asset("assets/climbMan.png"),
            Container(
              height: 5,
            ),
            Text(
              "Selecciona tú Sector",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Loans()));
                    },
                    child: Image.asset(
                      "assets/list1.png",
                      height: 40,
                    ),
                  ),
                  Text(
                    "Sector Educativo",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Loans()));
                    },
                    child: Image.asset(
                      "assets/list2.png",
                      height: 40,
                    ),
                  ),
                  Text(
                    "Sector Salud",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Loans()));
                    },
                    child: Image.asset(
                      "assets/list3.png",
                      height: 40,
                    ),
                  ),
                  Text(
                    "Sector Gobierno",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Loans()));
                    },
                    child: Image.asset(
                      "assets/list4.png",
                      height: 40,
                    ),
                  ),
                  Text(
                    "Jubilados y Pensionados",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  Container(
                    width: 15,
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
            ),
          ],
        ),
      )),
    );
  }
}
