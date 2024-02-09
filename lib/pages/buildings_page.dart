import 'package:flutter/material.dart';
import 'package:login_page/components/my_textfield.dart';

class BuildingsPage extends StatelessWidget {
  const BuildingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController streetNumberController = TextEditingController();
    TextEditingController streetNameController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController postalCodeController = TextEditingController();
    TextEditingController countryController = TextEditingController();

    return Center(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('BUILDINGS'),
              const SizedBox(height: 40),
              MyTextField(
                controller: streetNumberController,
                hintText: 'Street Number',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: streetNameController,
                hintText: 'Street Name',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: cityController,
                hintText: 'City',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: stateController,
                hintText: 'State',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: postalCodeController,
                hintText: 'Postal Code',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: countryController,
                hintText: 'Country',
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
                    child: const Text('Find Building'),
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
                    child: const Text('Update Building'),
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
                    child: const Text('Delete Building'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
