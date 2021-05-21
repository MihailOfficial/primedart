import 'package:path_provider/path_provider.dart';
import 'dart:io';


class Data {
  String _contentOfFile = "";
  var arr = ["","","","","",""];
  bool finished = false;


  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/demoTextFile.txt';

    return filePath;
  }

  void saveFile(String temp) async {

    File file = File(await getFilePath());

    file.writeAsString(temp);
  }



  Future<List<String>> readFile() async {
    var arr1 = ["","","","","",""];
    File file = File(await getFilePath());
    String fileContent = await file.readAsString();

    if (file == null){
      saveFile("0/0/0/0/0/0");
    } else {
      int indexLoc = 0;
      for (int i =0; i<fileContent.length; i++){
        if (fileContent[i] == '/'){
          indexLoc++;
        }
        else {
          arr1[indexLoc] += fileContent[i];
        }
      }

    }
    arr = arr1;
    return arr1;

  }

  List<String> returnData(){
    return this.arr;
  }

}