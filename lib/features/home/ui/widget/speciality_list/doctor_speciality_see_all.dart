import 'package:flutter/material.dart';

import '../../../../../core/theming/styles.dart';

class DoctorSpecialtySeeAll extends StatelessWidget {
  const DoctorSpecialtySeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Doctor Speciality",
          style: TextStyles.font18DarkBlueBold,
        ),
        const Spacer(),
        Text(
          "See All",
          style: TextStyles.font12BlueRegular,
        ),
      ],
    );
  }
}
