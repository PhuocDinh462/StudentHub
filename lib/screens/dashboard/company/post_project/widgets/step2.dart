import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/project.provider.dart';
import 'package:student_hub/utils/extensions.dart';

class Step2 extends StatelessWidget {
  Step2({
    super.key,
    required this.back,
    required this.next,
  });
  final _formKey = GlobalKey<FormState>();
  final VoidCallback back;
  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('2/4\t\t\t\t\tNext, estimate the scope of your project',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Center(
            child: Image.asset(
              'assets/images/Coding-workshop.png',
              width: context.deviceSize.width / 1.5,
            ),
          ),
          const Gap(5),
          Text('How long will your project take?',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(5),
          Column(
            children: [
              Row(
                children: [
                  Radio(
                    value: ProjectScopeFlag.oneToThreeMonth,
                    groupValue: projectProvider.getProjectScope,
                    onChanged: (value) =>
                        projectProvider.setProjectScope = value!,
                  ),
                  const Text('1 to 3 months'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: ProjectScopeFlag.threeToSixMonth,
                    groupValue: projectProvider.getProjectScope,
                    onChanged: (value) =>
                        projectProvider.setProjectScope = value!,
                  ),
                  const Text('3 to 6 months'),
                ],
              ),
            ],
          ),
          const Gap(20),
          Text('How many students do you want for this project?',
              style: Theme.of(context).textTheme.titleLarge),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => projectProvider.getNumOfStudents > 1
                      ? projectProvider.removeStudents()
                      : null,
                  icon: const Icon(Icons.remove)),
              const Gap(20),
              NumberPicker(
                value: projectProvider.getNumOfStudents,
                selectedTextStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : primary_300,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
                minValue: 1,
                maxValue: 100,
                itemHeight: 60,
                itemWidth: 60,
                axis: Axis.horizontal,
                onChanged: (value) => projectProvider.setNumOfStudents = value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? text_300
                          : primary_300,
                      width: 2),
                ),
              ),
              const Gap(20),
              IconButton(
                  onPressed: () => projectProvider.getNumOfStudents < 100
                      ? projectProvider.addStudents()
                      : null,
                  icon: const Icon(Icons.add)),
            ],
          ),
          const Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? text_800
                            : text_300,
                  ),
                  onPressed: () => back(),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Gap(15),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) next();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary_300,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: text_50,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
