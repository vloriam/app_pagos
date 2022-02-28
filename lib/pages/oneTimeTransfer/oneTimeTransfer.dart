import 'package:bankx/pages/screens.dart';

class OneTimeTransfer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 1.0,
        title: Text(
          'One Time Transfer',
          style: black18BoldTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: WithAccountNumber(),
              ),
            ),
            child: oneTimeTransferFunctionalities(
              title: 'Account Number',
              description: 'Transfer without adding beneficiary',
            ),
          ),
          oneTimeTransferFunctionalities(
            title: 'Unified Payments Interface (UPI)',
            description: 'Transfer through virtual payment address',
          ),
          oneTimeTransferFunctionalities(
            title: 'Repeat transactions',
            description: 'Repeat a recent transaction',
          ),
        ],
      ),
    );
  }

  oneTimeTransferFunctionalities({title, description}) {
    return Container(
      margin: EdgeInsets.only(
        left: fixPadding * 2.0,
        right: fixPadding * 2.0,
        top: fixPadding * 2.0,
      ),
      padding: EdgeInsets.all(fixPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1.0,
            blurRadius: 4.0,
            color: greyColor.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.20),
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor),
                  ),
                  child: Icon(
                    Icons.compare_arrows,
                    color: primaryColor,
                  ),
                ),
                widthSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: black14BoldTextStyle,
                      ),
                      height5Space,
                      Text(
                        description,
                        style: grey12RegularTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            size: 24,
            color: blackColor,
          ),
        ],
      ),
    );
  }
}
