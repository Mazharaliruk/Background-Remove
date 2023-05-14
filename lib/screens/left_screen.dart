import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:remove_bg/remove_bg.dart';

class LeftScreen extends StatefulWidget {
  const LeftScreen({Key? key}) : super(key: key);

  @override
  State<LeftScreen> createState() => _LeftScreenState();
}

class _LeftScreenState extends State<LeftScreen> {
  XFile? _image;

  final picker = ImagePicker();
  Uint8List? file;
  Future<void> getImage() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      _image = XFile(photo.path);
      print(_image!.path);
      await removeBackground(_image!.path);
      setState(() {

      });
    } else {
      print("Please select an image.");
    }
  }

  Future<void> removeBackground(String imgPath) async {
    Remove().bg(
      File(_image!.path),
      privateKey: "raq5Bw8Cgfn2Ws4SXTHLKF4o", // (Keep Confidential)
      onUploadProgressCallback: (progressValue) {
        if (kDebugMode) {
          print(progressValue);
        }
        setState(() {

        });
      },
    ).then((Uint8List? data) async {
      if (kDebugMode) {
        file = data;
      }

      setState(() {});
    });

    // var request = http.MultipartRequest("POST",Uri.parse("https://api.remove.bg/v1.0/removebg"));
    //
    // request.files.add(await http.MultipartFile.fromString("image_file", imgPath));
    // request.headers.addAll({
    //   "X-API-Key":"raq5Bw8Cgfn2Ws4SXTHLKF4o"
    // });
    // final response = await request.send();
    // if(response.statusCode == 200){
    //   http.Response imgRes = await http.Response.fromStream(response);
    //   // file = imgRes.bodyBytes;
    // }else{
    //   print("Error accoured : ${response.statusCode}");
    // }
  }

  buildButton({required String text,dynamic onPress}){

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: MediaQuery.of(context).size.height*.05,
          width: MediaQuery.of(context).size.width*.2,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Text(text,style: TextStyle(fontSize: 18),)),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              decoration: _image != null?BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image:FileImage(File(_image!.path)
                      ),
                      fit: BoxFit.cover
                  )
              ):BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: _image !=null?Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .04,
                        width: MediaQuery.of(context).size.width * .3,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Text(
                            "Original",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          getImage();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .04,
                          width: MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              "Retake",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ):InkWell(
                  onTap: (){
                    getImage();
                  },
                  child: Center(child: Text("Take Picture"),
                  )
              ),
            ),

            file !=null?  Container(
                height: MediaQuery.of(context).size.height * .3,
                width: double.infinity,
                decoration:BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      image:MemoryImage(file!)
                  ),
                ),
                child:Stack(
                  children: [
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .04,
                          width: MediaQuery.of(context).size.width * .3,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Center(
                            child: Text(
                              "Edited",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ) :const Text(""),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height*.06,
                          width: MediaQuery.of(context).size.width*.4,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Text("Resolution: ",
                                  style: TextStyle(fontSize: 20),),
                                Text("Medium ",
                                  style: TextStyle(fontSize: 20),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height*.06,
                          width: MediaQuery.of(context).size.width*.02,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)

                          ),
                          child: Icon(Icons.delete_outline_sharp,color: Colors.white,size: 35,),
                        )
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child:  buildButton(
                        text: "Front",
                        onPress: (){

                        }
                    ),),
                    Expanded(child:  buildButton(
                        text: "Back",
                        onPress: (){

                        }
                    ),),
                    Expanded(child:  buildButton(
                        text: "Left",
                        onPress: (){

                        }
                    ),),
                    Expanded(child:  buildButton(
                        text: "Right",
                        onPress: (){

                        }
                    ),),
                    Expanded(child:  buildButton(
                        text: "Top",
                        onPress: (){

                        }
                    ),),
                    Expanded(
                      flex: 2,
                      child:  buildButton(
                          text: "Bottom",
                          onPress: (){

                          }
                      ),),
                  ],
                )
              ],
            )
          ],
        ),
      ),

    );
  }
}
