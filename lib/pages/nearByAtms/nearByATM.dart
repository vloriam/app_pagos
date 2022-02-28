import 'package:bankx/pages/nearByAtms/atmModel.dart';
import 'package:bankx/pages/screens.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearByATMs extends StatefulWidget {
  @override
  _NearByATMsState createState() => _NearByATMsState();
}

class _NearByATMsState extends State<NearByATMs> {
  GoogleMapController _controller;
  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;
  @override
  void initState() {
    super.initState();
    atms.forEach((element) {
      allMarkers.add(
        Marker(
          markerId: MarkerId(element.bankname),
          draggable: false,
          infoWindow: InfoWindow(
            title: element.bankname,
            snippet: element.address,
          ),
          position: element.locationCoords,
        ),
      );
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.65)
      ..addListener(_onScroll);
  }

  _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _bankList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, widget) {
        double value = 1.0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.35) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 160.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: fixPadding,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: fixPadding,
          vertical: fixPadding,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(fixPadding),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 4.0,
              color: greyColor.withOpacity(0.5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  atms[index].bankname,
                  style: black14BoldTextStyle,
                ),
                height5Space,
                Text(
                  atms[index].address,
                  style: grey12RegularTextStyle,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${atms[index].rating}',
                  style: black14RegularTextStyle,
                ),
                SizedBox(width: 3.0),
                Icon(
                  Icons.star,
                  color: Color(0xffBFDC0F),
                  size: 18.0,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Distance',
                      style: grey12RegularTextStyle,
                    ),
                    height5Space,
                    Text(
                      '${atms[index].distance} km',
                      style: black14BoldTextStyle,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: fixPadding * 2.0,
                    vertical: fixPadding - 5.0,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(fixPadding * 2.0),
                  ),
                  child: Text(
                    'Direction',
                    style: black12MediumTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 1.0,
        title: Text(
          'Nearby ATMs',
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 12.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: atms.length,
                itemBuilder: (context, index) {
                  return _bankList(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: atms[_pageController.page.toInt()].locationCoords,
          zoom: 14.0,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }
}
