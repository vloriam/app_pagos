import 'package:bankx/pages/screens.dart';

class FormPartThree extends StatefulWidget {
  final String loanType;
  final String number;
  final String dueAmount;
  final String emiAmount;
  FormPartThree({this.loanType, this.number, this.dueAmount, this.emiAmount});
  @override
  _FormPartThree createState() => _FormPartThree();
}

class _FormPartThree extends State<FormPartThree> {
  double height;
  String _value = 'Institución';
  int _value2 = 1;
  bool valuefirst = false;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'Solicitud de Crédito',
          style: black18BoldTextStyle,
        ),
        toolbarHeight: 50, // default is 56
        toolbarOpacity: 0.5,
        shape: StadiumBorder(),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: orangeColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace,
                height5Space,
                customerEdoDropdown(),
                height20Space,
                customerInstDropdown(),
                height20Space,
                customerCheck(),
                height20Space,
                countinueButton()
              ],
            ),

        ],
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
          child: FormPartThree(),
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
          'Enviar Solicitud',
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  customerCheck(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      padding: EdgeInsets.symmetric(
        horizontal: fixPadding + 5.0,
        vertical: fixPadding - 6.0,
      ),
      /*
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
      ),*/
      child:
        Row(
          children:[
          Checkbox(
            checkColor: Colors.orange,
            activeColor: Colors.green,
            value: this.valuefirst,
            onChanged: (bool value) {
              setState(() {
                this.valuefirst = value;
              });
            },
          ),
          Text(
            'Acepto los términos y condiciones.',
            style:  TextStyle(fontSize: 12.0, color: Colors.grey,)
          ),
      ]
        )
    );
  }

  customerEdoDropdown() {
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
      child: DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                child: Text("Morelos"),
                value: 'Institución',
              ),
              DropdownMenuItem(
                child: Text("CDMX"),
                value: 'Institución 2',
              ),
              DropdownMenuItem(
                child: Text("Puebla"),
                value: 'Institución 3',
              )
            ],
            onChanged: (String value) {
              setState(() {
                _value = value;
              });
            },
            hint: Text("Selecciona un Estado")
      ),
    );
  }

  customerInstDropdown() {
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
      child: DropdownButton(
          value: _value2,
          items: [
            DropdownMenuItem(
              child: Text("Físcalia General"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("IMSS"),
              value: 2,
            ),
            DropdownMenuItem(
              child: Text("ISSSTE"),
              value: 3,
            )
          ],
          onChanged: (int value) {
            setState(() {
              _value2 = value;
            });
          },
          hint: Text("Selecciona una Institución")
      ),
    );
  }
}
