import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit(
      {super.key, required this.patientName, required this.patientContact, required this.patientPhoto});
  final String? patientName, patientContact, patientPhoto;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: patientName);
    TextEditingController contactController =
        TextEditingController(text: patientContact);
    //for image
    Future<PickedFile?>? imageFile;
    String? path;
    final picker = ImagePicker();
    void getFileImage() {
      if (imageFile != null) {
        imageFile!.then((file) {
          ImageUploadModel imageUpload = ImageUploadModel();
          imageUpload.imageFile = File(file!.path);
          path = file.path;
        });
      }
    }

    Future onAddImageClick(int type) async {
      imageFile = picker.getImage(
        source: type == 1 ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );
      getFileImage();
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //start edit image
            Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  path != null && path != ''
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(File(path!)),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(patientPhoto??defaultImageUrl),
                        ),
                  CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          // _showImagePicker(context);
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        onAddImageClick(1);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          onAddImageClick(2);
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(CupertinoIcons.camera,size: 18,)),
                  )
                ],
              ),
            ),
            //end edit image

            const SizedBox(
              height: 8,
            ),

            //start edit Name
            Text(
              '\nFull Name',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end edit Name
            const SizedBox(
              height: 8,
            ),
            //start edit contact
            Text(
              '\nContact',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end edit contact
          ],
        ),
      ),
    );
  }
}

class ImageUploadModel {
  File? imageFile;

  ImageUploadModel({
    this.imageFile,
  });
}
