import 'dart:io';

import 'package:bankx/pages/screens.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'No autorizado';
  bool tooManyAttempt = false;
  bool _isFingerPrintBiometricAvailable;
  bool progress;
  bool cancelTapOnFingerprintDialog;
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
  }

  fingerPrintAuth() async {
    await _checkBiometrics();
    if (!_canCheckBiometrics) {
      setState(() {
        _authorized = 'Sensor de Huella no disponible';
      });
    }

    if (_canCheckBiometrics) {
      await _getAvailableBiometrics();
      for (int i = 0; i < _availableBiometrics.length; i++) {
        if (_availableBiometrics[i] == BiometricType.fingerprint) {
          _isFingerPrintBiometricAvailable = true;
        }
      }

      if (!_isFingerPrintBiometricAvailable) {
        setState(() {
          _authorized = 'Sensor de Huella disponible.';
        });
      }

      if (_isFingerPrintBiometricAvailable) {
        await _authenticate();
      }
    }
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    String exceptionMsg;
    try {
      setState(() {
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Escanea tu huella para identificarte',
        useErrorDialogs: false,
        stickyAuth: true,
      );
      setState(() {
        _authorized = 'Autentificando';
      });
    } on PlatformException catch (e) {
      print(e);
      exceptionMsg = e.message;
    }
    if (!mounted) return;

    final String message = authenticated
        ? 'Autenticación por Huella Exitoso.'
        : (exceptionMsg != null)
            ? exceptionMsg
            : 'No autorizado';
    if (authenticated) {
      tooManyAttempt = false;
      Navigator.push(
        context,
        PageTransition(
          duration: Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: Register(),
        ),
      );
    }
    setState(() {
      _authorized = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                bankXWithImage(),
                height20Space,
                Text(
                  'Iniciar sesión',
                  style: black14MediumTextStyle,
                ),
                height20Space,
                customerIdTextField(),
                height20Space,
                mPinTextField(),
                height20Space,
                countinueButton(),
                height20Space,
                Text(
                  '¿Eres Nuevo Usuario?',
                  style: black16MediumTextStyle,
                ),
                height20Space,
                Text(
                  'Escanea tu huella',
                  style: black14MediumTextStyle,
                ),
                height20Space,
                InkWell(
                  onTap: () => fingerPrintAuth(),
                  child: Icon(
                    Icons.fingerprint,
                    size: 68.0,
                    color: primaryColor,
                  ),
                ),
                height20Space,
                Text(
                  _authorized,
                  style: red14MediumTextStyle,
                ),
                Text(
                  'Ó conectate con:',
                  textAlign: TextAlign.center,
                  style: black14MediumTextStyle,
                ),
                otherOptions(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: fixPadding * 2.0,
                    left: fixPadding * 2.0,
                    right: fixPadding * 2.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bankXWithImage() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        color: blackColor,
        image: DecorationImage(
          image: AssetImage('assets/banking.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '',
          style: white36BoldTextStyle,
        ),
      ),
    );
  }

  countinueButton() {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          duration: Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: Register(),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        padding: EdgeInsets.symmetric(
          vertical: fixPadding + 4.0,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'Continuar',
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  customerIdTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding + 5.0,
        vertical: fixPadding - 6.0,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        cursorColor: primaryColor,
        style: black14MediumTextStyle,
        decoration: InputDecoration(
          hintStyle: black14MediumTextStyle,
          hintText: 'Nombre de Usuario',
          border: InputBorder.none,
        ),
      ),
    );
  }

  mPinTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding + 5.0,
        vertical: fixPadding - 6.0,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        cursorColor: primaryColor,
        style: black14MediumTextStyle,
        decoration: InputDecoration(
          hintStyle: black14MediumTextStyle,
          hintText: 'Escribir Contraseña',
          border: InputBorder.none,
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Presiona de Nuevo para Salir.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  otherOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: fixPadding * 2.0,
        vertical: fixPadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45.0,
              padding: EdgeInsets.all(fixPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff4267b2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/facebook-icon.png',
                    height: 20.0,
                    width: 25.0,
                  ),
                  widthSpace,
                  Text(
                    'Facebook',
                    style: white16BoldTextStyle,
                  ),
                ],
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          widthSpace,
          Expanded(
            child: Container(
              height: 45.0,
              padding: EdgeInsets.all(fixPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffea4335),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/google+_icon.png',
                    height: 25.0,
                    width: 25.0,
                  ),
                  widthSpace,
                  widthSpace,
                  Text(
                    'Google+',
                    style: white16BoldTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
