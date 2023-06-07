import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/edit_profile/edit_profile_scr.dart';
import 'package:xcel_medical_center/utils/get_user_info.dart';
import 'package:xcel_medical_center/widgets/setting_listtile.dart';
import 'package:xcel_medical_center/widgets/show_snack.dart';
import '../../../dialogs/dialog_change_password.dart';
import '../home/components/drawer/drawer_menu.dart';

class SettingsEcelPatient extends StatefulWidget {
  const SettingsEcelPatient({super.key});

  @override
  SettingsEcelPatientState createState() => SettingsEcelPatientState();
}

class SettingsEcelPatientState extends State<SettingsEcelPatient> {
  String patientName = '',
      patientContact = '',
      patientPhoto = '',
      patientEmail = '',
      userPassport = '',
      dob = '',
      bloodGroup = '',
      gender = '';

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        patientName = value.patientName ?? '';
        patientContact = value.patientMob ?? '';
        patientPhoto = value.patientPhoto ?? defaultImageUrl;
        patientEmail = value.patientEmail ?? '';
        userPassport = value.userPass ?? '';
        dob = value.dob ?? '';
        bloodGroup = value.bloodGroup ?? '';
        gender = value.gender ?? '';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBAr = AppBar(
      title: const Text(
        "Setting",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 19),
      ),
    );
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
          appBar: appBAr,
          drawer: const DrawerMenu(),
          body: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surfaceVariant)),
                  child: Row(
                    children: [
                      //image
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            image: DecorationImage(
                                image: NetworkImage(patientPhoto.isNotEmpty
                                    ? patientPhoto
                                    : defaultImageUrl),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      //name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patientName,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Divider(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                            Text(
                              patientEmail,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .fontSize,
                              ),
                            ),
                            Text(patientContact,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //end edit profile

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Personalized',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      settingListTile(context,
                          title: "Change Password",
                          leadingColor: CupertinoColors.systemYellow,
                          icon: CupertinoIcons.lock_fill, onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DialogChangePassword(
                                listener: (isSuccess) {
                                  showSnack('Successfully Password Changed');
                                  debugPrint(
                                      "pass****************************");
                                },
                              );
                            });
                      }),
                      settingListTile(context,
                          title: "Edit Profile",
                          leadingColor: CupertinoColors.activeGreen,
                          icon: CupertinoIcons.pencil, onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EditProfileScreen(
                                      patientName: patientName,
                                      patientContact: patientContact,
                                      patientPhoto: patientPhoto.isNotEmpty
                                          ? patientPhoto
                                          : defaultImageUrl,
                                      patientEmail: patientEmail,
                                      userPassport: userPassport,
                                      dob: dob,
                                      bloodGroup: bloodGroup,
                                      gender: gender,
                                    )));
                      })
                    ],
                  ),
                ),
              ])),
    );
  }
}
