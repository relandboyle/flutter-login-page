import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 375,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Welcome to HeatSync.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 80),
                const Text(
                    'The purpose of the HeatSync application is to provide a tool for tenants in rent-controlled apartments to collect reliable, consistent temperature data which may be used to fight against negligent or abusive landlords.'),
                const SizedBox(height: 40),
                const Text(
                    'It is unfortunately quite common for landlords to deprive tenants of heat during the colder months of the year. While tenants can and do report these conditions to the NYC Department of Housing Preservation and Development (HPD), it typically takes several days to dispatch inspectors to the site and the inspections are scheduled in cooperation with landlords.'),
                const SizedBox(height: 40),
                const Text(
                    'The requirements for landlords are clearly defined. From October 1st to May 31st, the temperature inside all units must be within the following limits:'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Image.asset(
                        'lib/images/heat_season.png',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                    'The HeatSync application collects and stores temperature data from inside the unit as well as the outside air temperature at the same moment in time. By comparing the inside and outside temperatures and considering the time of day and the calendar date, we can determine if and when violations occur. This information may be used by tenants or their representatives to compel private ladlords or city agents and courts to take action to protect tenants\' rights and welfare.'),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('If you would like to participate in the HeatSync program, please email Reland at:'),
                    SelectableText(
                      'RBoyleSW@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
