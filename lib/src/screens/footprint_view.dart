import 'package:flutter/material.dart';
import '../obj/trip.dart';

class FootprintView extends StatefulWidget {
  const FootprintView({super.key});

  static const routeName = '/footprint';

  @override
  State<FootprintView> createState() => _FootprintState();
}

class _FootprintState extends State<FootprintView> {
  List<Trip> trips = [Trip(1.0, 'Car'), Trip(2.0, 'Bus')];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _distanceController = TextEditingController();
  String _selectedTransport = 'Car';
  bool _isFormVisible = false;

  final Map<String, double> emissionFactors = {
    'Car': 0.21,
    'Bus': 0.08,
    'Train': 0.04,
    'Bicycle': 0.0,
    'Walking': 0.0,
  };

  double getTotalEmissions() {
    return trips.fold(
      0.0,
      (sum, trip) => sum + (trip.distance * emissionFactors[trip.transport]!),
    );
  }

  Icon _getTransportIcon(String transport) {
    return const Icon(Icons.fire_truck);
  }

  void _addTrip() {
    if (_formKey.currentState!.validate()) {
      final double distance = double.parse(_distanceController.text);
      final String transport = _selectedTransport;
      setState(() {
        trips.add(Trip(distance, transport));
        _isFormVisible = false;
      });
      _distanceController.clear();
    }
  }

  void _showForm() {
    setState(() {
      _isFormVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(
                          value: getTotalEmissions() / 10,
                          color: Colors.lightGreen,
                          backgroundColor:
                              const Color.fromARGB(200, 200, 200, 1),
                          strokeWidth: 24.0,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ),
                    Text(
                      'Total Carbon Emissions: ${getTotalEmissions().toStringAsFixed(2)} kg CO2',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   child: const CircleAvatar(
              //     radius: 100,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: _isFormVisible
                    ? Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _distanceController,
                              decoration: const InputDecoration(
                                labelText: 'Distance (km)',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a distance';
                                }
                                final double? distance = double.tryParse(value);
                                if (distance == null || distance <= 0) {
                                  return 'Please enter a valid distance';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              value: _selectedTransport,
                              items: emissionFactors.keys
                                  .map(
                                    (transport) => DropdownMenuItem(
                                      value: transport,
                                      child: Text(transport),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedTransport = value!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Transport Mode',
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _addTrip,
                              child: const Text('Add Trip'),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: _showForm,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          height: 60,
                          width: 200,
                          alignment: Alignment.center,
                          child: const Text(
                            "New Trip",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(15, 22, 38, 1),
                  boxShadow: [BoxShadow(color: Colors.black)],
                ),
                child: !_isFormVisible
                    ? Column(
                        children: [
                          const Text(
                            "Previous Trips",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .4,
                            child: ListView.builder(
                              restorationId: 'navListView',
                              itemCount: trips.length,
                              itemBuilder: (BuildContext context, int index) {
                                final trip = trips[index];
                                return ListTile(
                                  title: Text(
                                      "${trip.transport} travelled ${trip.distance} km"),
                                  leading: _getTransportIcon(trip.transport),
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
