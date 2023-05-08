import 'package:flutter/material.dart';
import 'package:meowdicine/objects/animal.dart';
import 'package:meowdicine/http/backend_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  DateTime _selectedDate = _getInitialDate();
  String _token = '';

  @override
  void initState() {
    super.initState();
    _initToken();
  }

  void _initToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token;
      });
    } else {
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  static DateTime _getInitialDate() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  Widget _showInputDatePickerFormField() {
    return InputDatePickerFormField(
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDate: _selectedDate,
        onDateSubmitted: (DateTime value) {
          _setDate(value);
        });
  }

  void _showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: _selectedDate,
    );
    if (pickedDate != null) {
      _setDate(pickedDate);
    }
  }

  // setDate method that makes sure to set the time of day to 00:00
  void _setDate(DateTime date) {
    setState(() {
      _selectedDate = DateTime(date.year, date.month, date.day);
    });
  }

  String _dateAsStringWithoutTime() {
    return _selectedDate.toString().split(' ')[0];
  }

  void _createAnimal(BuildContext context, Animal animal) async {
    try {
      final response = await BackendApi.addAnimal(_token, animal);
      if (response.statusCode == 201) {
        if (context.mounted) {
          Navigator.pop(context);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Feil'),
                content: const Text('Kunne ikke legge til dyr'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Feil'),
                Icon(
                  Icons.error,
                  color: Colors.red,
                )
              ],
            ),
            content: const Text('Klarte ikke opprette dyr'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();

  TextStyle _titleStyle() {
    return TextStyle(
      fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
      fontWeight: Theme.of(context).textTheme.headlineMedium!.fontWeight,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Legg til dyr',
                style: _titleStyle(),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Navn',
                            prefixIcon: Icon(Icons.badge),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _speciesController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Art',
                            prefixIcon: Icon(Icons.pets),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: TextEditingController(
                              text: _dateAsStringWithoutTime()),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Fødselsdato',
                            prefixIcon: IconButton(
                                onPressed: () {
                                  _showDatePickerDialog();
                                },
                                icon: const Icon(Icons.calendar_today)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Avbryt'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final Animal animal = Animal(
                                name: _nameController.text,
                                species: _speciesController.text,
                                birthday: _selectedDate,
                              );
                              _createAnimal(context, animal);
                            },
                            child: const Text('Legg til'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
