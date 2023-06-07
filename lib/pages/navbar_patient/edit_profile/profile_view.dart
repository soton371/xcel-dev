import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class ProfileView extends StatelessWidget {
  const ProfileView(
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(patientPhoto ?? defaultImageUrl),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Personal Details\n",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  patientContact ?? '',
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "\nPersonal Information",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(),
          Row(
            children: [
              infoTile(context,'Mail',patientEmail??''),
              infoTile(context,'Blood Group',bloodGroup??''),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              infoTile(context,'Date of Birth',dob??''),
              infoTile(context,'Gender',gender??''),
            ],
          ),
        ],
      ),
    );
  }
}

Widget infoTile(context,String level, String value) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          level,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
              color: Colors.blueGrey),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.black54),
        )
      ],
    ),
  );
}
