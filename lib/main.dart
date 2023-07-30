import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String confidence = '';
  String label = '';
  File? _image;

  void initML() async {
    // String? res = await Tflite.loadModel(
    //     model: "assets/mobilenet_v1_1.0_224.tflite",
    //     labels: "assets/labels.txt",
    //     numThreads: 1, // defaults to 1
    //     isAsset: true, // defaults to true, set to false to load resources outside assets
    //     useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    //     );

    // print(res);
  }

  void runRecogOnImage(File image) async {
    // List<dynamic>? recognitions = await Tflite.runModelOnImage(
    //     path: image.path, // required
    //     imageMean: 0.0, // defaults to 117.0
    //     imageStd: 255.0, // defaults to 1.0
    //     numResults: 2, // defaults to 5
    //     threshold: 0.2, // defaults to 0.1
    //     asynch: true // defaults to true
    //     );

    // print(recognitions);

    // // just for display:
    // setState(() {
    //   if (recognitions != null) {
    //     confidence = (recognitions.first['confidence'] * 100).truncate().toString();
    //     label = recognitions.first['label'];
    //   }

    //   _image = image;
    // });
  }

  void takePic() async {
    // take a pic and pass it to runRecogOnImage
    // Select image from the camera
    XFile? xPickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 500,
      maxHeight: 500,
    );

    if (xPickedFile == null) return;

    File pickedFile = File(xPickedFile.path);
    runRecogOnImage(pickedFile);
  }

  void disposeML() async {
    // await Tflite.close();
  }

  @override
  void initState() {
    super.initState();

    initML();
  }

  @override
  void dispose() {
    super.dispose();

    disposeML();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('tflite_flutter image recognition example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8.0),
            if (_image != null) Image.file(File(_image!.path)),
            if (label != '') Text(label),
            if (confidence != '') Text(confidence),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takePic,
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt_rounded),
      ),
    );
  }
}


    // var recognitions = await Tflite.detectObjectOnImage(
    //   path: filepath,       // required
    //   model: "SSDMobileNet",
    //   imageMean: 127.5,     
    //   imageStd: 127.5,      
    //   threshold: 0.4,       // defaults to 0.1
    //   numResultsPerClass: 2,// defaults to 5
    //   asynch: true          // defaults to true
    // );

    // var recognitions = await Tflite.detectObjectOnImage(
    //   path: filepath,       // required
    //   model: "YOLO",      
    //   imageMean: 0.0,       
    //   imageStd: 255.0,      
    //   threshold: 0.3,       // defaults to 0.1
    //   numResultsPerClass: 2,// defaults to 5
    //   anchors: anchors,     // defaults to [0.57273,0.677385,1.87446,2.06253,3.33843,5.47434,7.88282,3.52778,9.77052,9.16828]
    //   blockSize: 32,        // defaults to 32
    //   numBoxesPerBlock: 5,  // defaults to 5
    //   asynch: true          // defaults to true
    // );