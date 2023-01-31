import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GroupCard extends StatelessWidget {
  final int index;
  const GroupCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          debugPrint('flutter group chat $index');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.maxFinite,
          height: 70,
          decoration: BoxDecoration(
            color: Color.fromRGBO(214, 224, 239, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/flutt.jpg'),
              ),
              Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Flutter',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Gap(10),
                  Text(
                    'lorem ipsum dolor isem ...',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Text(
                '10:00 am',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
