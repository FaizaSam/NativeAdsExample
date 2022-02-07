import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeNativeAdExample(),
    );
  }
}

class HomeNativeAdExample extends StatefulWidget {
  // HomeNativeAdExample({Key? key}) : super(key: key);

  @override
  State<HomeNativeAdExample> createState() => _HomeNativeAdExampleState();
}

class _HomeNativeAdExampleState extends State<HomeNativeAdExample> {
  NativeAd _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadNativeAd();
  }

  void loadNativeAd() {
    _ad = NativeAd(
        adUnitId: 'ca-app-pub-3940256099942544/2247696110',
        factoryId: 'listTile',
        listener: NativeAdListener(onAdLoaded: (ad) {
          print('Ad Loaded');
          setState(() {
            isLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Failed to load the ad ${error.message}, ${error.code}');
        }),
        request: const AdRequest());
    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Native Ads"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              if (isLoaded && index == 2) {
                return Container(
                  child: AdWidget(
                    ad: _ad,
                  ),
                  alignment: Alignment.center,
                  height: 170,
                  color: Colors.black12,
                );
              } else {
                return ListTile(
                  title: Text('Item ${index + 1}'),
                  leading: const FlutterLogo(
                    size: 25,
                  ),
                  subtitle: Text('Subtitle for item ${index + 1}'),
                );
              }
            }),
      ),
    );
  }
}
