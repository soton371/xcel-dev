import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/pages/navbar_patient/edit_profile/profile_edit.dart';
import 'package:xcel_medical_center/pages/navbar_patient/edit_profile/profile_view.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {super.key,
      required this.patientName,
      required this.patientContact,
      required this.patientPhoto,
      required this.patientEmail,
      required this.userPassport,
      required this.dob,
      required this.bloodGroup,
      required this.gender});
  final String? patientName,
      patientContact,
      patientPhoto,
      patientEmail,
      userPassport,
      dob,
      bloodGroup,
      gender;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool editMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                editMode = !editMode;
              });
            },
            icon: Icon(editMode ? Icons.done : CupertinoIcons.pencil),
          )
        ],
      ),
      body: editMode
          ? ProfileEdit(
              patientName: widget.patientName,
              patientContact: widget.patientContact,
              patientPhoto: widget.patientPhoto)
          : ProfileView(
              patientName: widget.patientName,
              patientContact: widget.patientContact,
              patientPhoto: widget.patientPhoto,
              patientEmail: widget.patientEmail,
              userPassport: widget.userPassport,
              dob: widget.dob,
              bloodGroup: widget.bloodGroup,
              gender: widget.gender),
    );
  }
}
