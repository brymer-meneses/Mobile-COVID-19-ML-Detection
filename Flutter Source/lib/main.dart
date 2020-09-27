import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:relative_scale/relative_scale.dart';

import 'services/imageBox.dart';
import 'services/disclaimerNote.dart';
import 'package:covid19_ct_scan_classification/services/chooseImageMethod.dart';
import './ml-services/classifier.dart';
import './ml-services/classifier_float.dart';
import 'services/results.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(),
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// ------------------- Variables ---------------------------- //

  bool _showClassifyButton = false;
  bool _showPrompt = false;
  bool _isLoading = true;
  bool _displayResults = false;
  bool _showChooseImageButton = true;
  bool _showDisclaimerNote = true;

  File _image;

  num _covidPercent;
  num _nonCovidPercent;
  num _nonInformativePercent;

  Classifier _classifier;

// ---------------------------------------------------------------

// --------------- Getting image functions --------------------- //

  void _imageFromCamera() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);

      _image == null ? _showClassifyButton = false : _showClassifyButton = true;
      _image == null ? _showPrompt = true : _showPrompt = false;
    });
  }

  void _imageFromGallery() async {
    final picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      _image == null ? _showClassifyButton = false : _showClassifyButton = true;
      _image == null ? _showPrompt = true : _showPrompt = false;
    });
  }

  void _chooseImageMethod() {
    setState(() {
      _showPrompt = true;
      _image = null;
      _showClassifyButton = false;
      _showChooseImageButton = false;
      _displayResults = false;
      _showDisclaimerNote = false;
    });
  }

  // -------------------ML FUNCTIONS------------------- //
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _classifier = ClassifierFloat();
  }

  void _startClassifyingImage(File image) async {
    print('classifying image...');
    img.Image imageInput = img.decodeImage(image.readAsBytesSync());
    var pred = _classifier.predict(imageInput);
    print(pred);

    setState(() {
      _covidPercent = pred['covid'];
      _nonCovidPercent = pred['non-covid'];
      _nonInformativePercent = pred['non-informative'];

      _displayResults = true;
      _showClassifyButton = false;
      _showChooseImageButton = true;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
        builder: (context, screenHeight, screenWidth, sy, sx) {
      return Scaffold(
          appBar: AppBar(
              title: Text("COVID-19 A.I. DETECTION "),
              centerTitle: true,
              backgroundColor: Color(0xff192a56)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DisclaimerNote(_showDisclaimerNote),
              ChooseImageMethod(
                  _showPrompt, _imageFromGallery, _imageFromCamera),
              ImageBox(this._image),
              _showClassifyButton
                  ? Container(
                      child: FloatingActionButton.extended(
                        onPressed: () => _startClassifyingImage(_image),
                        backgroundColor: Color(0xff487eb0),
                        label: Text('Classify Image'),
                        tooltip: 'Run the ML model to classify the image! ',
                      ),
                    )
                  : Container(),
              _displayResults
                  ? _isLoading
                      ? Container(
                          child: CircularProgressIndicator(),
                          alignment: Alignment.center)
                      : Results(_covidPercent, _nonCovidPercent,
                          _nonInformativePercent)
                  : Container()
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _showChooseImageButton // if else
              ? Container(
                  margin: EdgeInsets.all(sy(7)),
                  child: FloatingActionButton.extended(
                    label: Text('Choose an image.'),
                    isExtended: true,
                    backgroundColor: Color(0xff273c75),
                    onPressed: _chooseImageMethod,
                    icon: Icon(Icons.add_a_photo),
                  ),
                )
              : null);
    });
  }
}
