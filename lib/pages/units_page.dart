import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

 @override
  Widget build(BuildContext context) {
    TextEditingController unitNumber = TextEditingController();
    TextEditingController tenantName = TextEditingController();
    TextEditingController buildingId = TextEditingController();

    return Center(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                const Text('UNITS'),
                const SizedBox(height: 40),
                MyTextField(
                  controller: unitNumber,
                  hintText: 'Street Number',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: tenantName,
                  hintText: 'Street Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: buildingId,
                  hintText: 'City',
                  obscureText: false,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
                        foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondaryContainer),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(15),
                        ),
                      ),
                      child: const Text('Find Unit'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
                        foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondaryContainer),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(15),
                        ),
                      ),
                      child: const Text('Update Unit'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
                        foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondaryContainer),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(15),
                        ),
                      ),
                      child: const Text('Delete Unit'),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
