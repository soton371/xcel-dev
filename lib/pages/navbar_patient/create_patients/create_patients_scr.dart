import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/create_patients/country_list/country_list.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';

class CreatePatientScreen extends StatefulWidget {
  const CreatePatientScreen({super.key});

  @override
  State<CreatePatientScreen> createState() => _CreatePatientScreenState();
}

class _CreatePatientScreenState extends State<CreatePatientScreen> {
  Set<String> selectGender = {"Male"};
  Set<String> selectIdentity = {"NID"};
  Set<String> selectMaritalStatus = {"Single"};
  String selectBlood = "Select";
  String selectReligion = "Select";
  String selectData = "Select Birth Day";
  String selectedNationality = 'Select';

  File? _image;

  Future<void> _pickImage(ImageSource source, context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  Future<void> _showImagePicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Create Patient'),
      ),
      body: SingleChildScrollView(
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
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://cdn141.picsart.com/321556657089211.png"),
                        ),
                  CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          _showImagePicker(context);
                        },
                        icon: const Icon(CupertinoIcons.pencil)),
                  )
                ],
              ),
            ),
            //end edit image
            const SizedBox(
              height: 40,
            ),

            //start Nid/Passport
            Center(
              child: SegmentedButton<String>(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                onSelectionChanged: (value) {
                  setState(() {
                    selectIdentity = value;
                  });
                },
                segments: const <ButtonSegment<String>>[
                  ButtonSegment<String>(
                    value: "Voter ID",
                    label: Text("Voter ID"),
                  ),
                  ButtonSegment<String>(
                    value: "NID",
                    label: Text("NID"),
                  ),
                  ButtonSegment<String>(
                      value: 'Passport', label: Text('Passport')),
                ],
                selected: selectIdentity,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                hintText: "Please Provide ${selectIdentity.first} No",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end Nid/Passport

            //start Full Name
            Row(
              children: [
                Text(
                  '\nFull Name',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Icon(
                  CupertinoIcons.staroflife_fill,
                  color: CupertinoColors.systemRed,
                  size: 8,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end Full Name

            //start Gender
            Row(
              children: [
                Text(
                  '\nGender',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Icon(
                  CupertinoIcons.staroflife_fill,
                  color: CupertinoColors.systemRed,
                  size: 8,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SegmentedButton<String>(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
              onSelectionChanged: (value) {
                setState(() {
                  selectGender = value;
                });
              },
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: "Male",
                  label: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Male",
                        textAlign: TextAlign.center,
                      )),
                ),
                ButtonSegment<String>(
                  value: "Female",
                  label: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Female",
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
              selected: selectGender,
            ),
            //end Gender

            //start blood group
            Text(
              '\nBlood Group',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            PopupMenuButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectBlood,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              onSelected: (value) {
                setState(() {
                  selectBlood = value;
                });
              },
              itemBuilder: (BuildContext bc) {
                return const [
                  PopupMenuItem(
                    value: 'A+',
                    child: Text("A+"),
                  ),
                  PopupMenuItem(
                    value: 'B+',
                    child: Text("B+"),
                  ),
                  PopupMenuItem(
                    value: 'O+',
                    child: Text("O+"),
                  ),
                  PopupMenuItem(
                    value: 'A-',
                    child: Text("A-"),
                  ),
                  PopupMenuItem(
                    value: 'B-',
                    child: Text("B-"),
                  ),
                  PopupMenuItem(
                    value: 'O-',
                    child: Text("O-"),
                  )
                ];
              },
            ),
            //end blood group

            //start Religion
            Text(
              '\nReligion',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            PopupMenuButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectReligion,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              onSelected: (value) {
                setState(() {
                  selectReligion = value;
                });
              },
              itemBuilder: (BuildContext bc) {
                return const [
                  PopupMenuItem(
                    value: 'Islam',
                    child: Text("Islam"),
                  ),
                  PopupMenuItem(
                    value: 'Christianity',
                    child: Text("Christianity"),
                  ),
                  PopupMenuItem(
                    value: 'Secular',
                    child: Text("Secular"),
                  ),
                  PopupMenuItem(
                    value: 'Hinduism',
                    child: Text("Hinduism"),
                  ),
                  PopupMenuItem(
                    value: 'Buddhism',
                    child: Text("Buddhism"),
                  )
                ];
              },
            ),
            //end Religion

            //start Marital Status
            Row(
              children: [
                Text(
                  '\nMarital Status',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Icon(
                  CupertinoIcons.staroflife_fill,
                  color: CupertinoColors.systemRed,
                  size: 8,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SegmentedButton<String>(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
              onSelectionChanged: (value) {
                setState(() {
                  selectMaritalStatus = value;
                });
              },
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: "Single",
                  label: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Single",
                        textAlign: TextAlign.center,
                      )),
                ),
                ButtonSegment<String>(
                  value: "Married",
                  label: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Married",
                        textAlign: TextAlign.center,
                      )),
                ),
                ButtonSegment<String>(
                  value: "Other",
                  label: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Other",
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
              selected: selectMaritalStatus,
            ),
            //end Marital Status

            //start Age
            Text(
              '\nAge',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end Age

            //start date of birth
            Text(
              '\nDate of Birth',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now()
                            .subtract(const Duration(days: 36500)),
                        lastDate: DateTime.now())
                    .then((value) {
                  String formateDate =
                      DateFormat.yMd().format(value ?? DateTime.now());
                  setState(() {
                    selectData = formateDate;
                  });
                });
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectData,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Icon(CupertinoIcons.calendar)
                  ],
                ),
              ),
            ),
            //end date of birth

            //start phone number
            Row(
              children: [
                Text(
                  '\nPhone No:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Icon(
                  CupertinoIcons.staroflife_fill,
                  color: CupertinoColors.systemRed,
                  size: 8,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end phone number

            //start E-mail
            Text(
              '\nE-mail',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end E-mail

            //start Nationality
            Text(
              '\nNationality',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            PopupMenuButton(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedNationality,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              onSelected: (value) {
                setState(() {
                  selectedNationality = value;
                });
              },
              itemBuilder: (BuildContext bc) {
                return nationalityList
                    .map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList();
              },
            ),
            //end Nationality

            //start Occupation
            Text(
              '\nOccupation',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
            ),
            //end Occupation
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              btnText: "Submit",
              btnColor: cViolet,
              onTap: () {},
            )
          ],
        ),
      )),
    );
  }
}
