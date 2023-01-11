import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

import 'colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var INFURA_PROJECT_ID = "abcc05a426r7g8b33442a3h53aea7a30";
  var infuraURl = "https://mainnet.infura.io/v3/INFURA_PROJECT_ID";

  // Create a connector
  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: PeerMeta(
      name: 'JCR WalletConnect',
      description: 'cybersoft WalletConnect Developer App',
      url: 'http://cybersoft.co.in/',
      icons: ['http://cybersoft.co.in/android_apps/logo/cybersoft_logo.png'],
    ),
  );

  var _session, session, uri;

  connectMetmaskWallet(BuildContext context) async {
    if (!connector.connected) {
      try {
        session = await connector.createSession(onDisplayUri: (_uri) async {
          uri = _uri;
          await launchUrlString(_uri, mode: LaunchMode.externalApplication);
        });
        setState(() {
          _session = session;
        });
        print(session);
        print(uri);
      } catch (error) {
        print("Error at connect $error");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Subscribe to events
    connector.on(
        'connect',
        (session) => setState(() {
              _session = session;
            }));
    connector.on(
        'session_update',
        (session) => setState(() {
              _session = session;
            }));
    connector.on(
        'disconnect',
        (session) => setState(() {
              _session = session;
            }));
    var account = session?.accounts[0];
    var chainID = session?.chainId;

    return Scaffold(
      backgroundColor: backgroud,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: accentColor,
        title: const Text(
          'JCR Wallet Connection',
        ),
      ),
      body: (session == null)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SIZE_BOX_20),
                  Container(
                    width: 120,
                    child: Image.asset(
                      'assets/icon/cybersoft_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: SIZE_BOX_20),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: FDottedLine(
                        color: green,
                        strokeWidth: 2.0,
                        dottedLength: 8.0,
                        space: 3.0,
                        corner: FDottedLineCorner.all(6.0),

                        /// add widget
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            color: bg_box_select,
                            height: 260,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: SIZE_BOX_20),
                                Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Please click button to connect with metamask wallet",
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: TEXT_SIZE_14,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          color: white),
                                    )),
                                SizedBox(height: SIZE_BOX_20),
                                Visibility(
                                  visible: true,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          height: 40,
                                          width: 180,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.fromLTRB(btnLEFT,
                                              btnTOP, btnRIGHT, btnBOTTOM),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: green),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Connect Wallet",
                                              style: GoogleFonts.lato(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: white),
                                            ),
                                          ),
                                        ),
                                        onTap: () =>
                                            connectMetmaskWallet(context),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: SIZE_BOX_20),
                                Text(
                                  "Manage By JCR",
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: TEXT_SIZE_12,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: box_dotted),
                                ),
                                SizedBox(height: SIZE_BOX_20),
                                Text(
                                  "http://cybersoft.co.in/",
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: TEXT_SIZE_12,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: box_dotted),
                                ),
                              ],
                            )),
                      )),
                ],
              ),
            )
          : (account != null)
              ? Column(
                  children: [
                    SizedBox(height: SIZE_BOX_20),
                    Container(
                      width: 120,
                      child: Image.asset(
                        'assets/icon/cybersoft_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: SIZE_BOX_20),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: FDottedLine(
                        color: green,
                        strokeWidth: 2.0,
                        dottedLength: 8.0,
                        space: 3.0,
                        corner: FDottedLineCorner.all(6.0),

                        /// add widget
                        child: Container(
                            padding: EdgeInsets.all(10.0),
                            color: bg_box_select,
                            height: 260,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(height: SIZE_BOX_20),
                                Text(
                                  "Public Address",
                                  style: GoogleFonts.lato(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: TEXT_SIZE_16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: white,
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "$account",
                                      style: GoogleFonts.lato(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: TEXT_SIZE_16,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                          color: white),
                                    )),
                                InkWell(
                                  onTap: () async {

                                    Clipboard.setData(
                                        ClipboardData(text: account));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                        'Public address copied to clipboard',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: TEXT_SIZE_15),
                                      )),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/icon/copy.png',
                                    fit: BoxFit.contain,
                                    width: 30,
                                  ),
                                ),
                                SizedBox(height: SIZE_BOX_20),
                                Text(
                                  "Manage By JCR",
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: TEXT_SIZE_12,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: box_dotted),
                                ),
                                SizedBox(height: SIZE_BOX_20),
                                Text(
                                  "http://cybersoft.co.in/",
                                  style: GoogleFonts.lato(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: TEXT_SIZE_12,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: box_dotted),
                                ),
                              ],
                            )),
                      ),
                    ),
                    // Text("chainID is $chainID"),
                  ],
                )
              : Text("No Account"),
    );
  }
}
