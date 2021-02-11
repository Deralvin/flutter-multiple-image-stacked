import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mulltiple_image/add_view_model.dart';
import 'package:path/path.dart' as Path;
import 'package:stacked/stacked.dart';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddViewModel>.reactive(
      viewModelBuilder: ()=> AddViewModel(),
      builder: (context,model,child) => Scaffold(
          appBar: AppBar(
            title: Text('Add Image'),
            actions: [
              FlatButton(
                  onPressed: () {
                    model.uploading=true;
                  },
                  child: Text(
                    'upload',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                child: GridView.builder(
                    itemCount: model.image.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                        child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () =>
                            !model.uploading ? model.chooseImage() : null),
                      )
                          : Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(model.image[index - 1]),
                                fit: BoxFit.cover)),
                      );
                    }),
              ),
              model.uploading
                  ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          'uploading...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        value: model.val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                  : Container(),
            ],
          )),
    );
  }




  @override
  void initState() {
    super.initState();
  }
}