import 'package:flutter/material.dart';
import 'package:meowdicine/objects/animal.dart';
import 'package:meowdicine/http/backend_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meowdicine/styles/styles.dart';

class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  DateTime _selectedDate = _getInitialDate();
  String _username = '';
  String _token = '';

  @override
  void initState() {
    super.initState();
    _initCredentials();
  }

  void _initCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final token = prefs.getString('token');
    if (username != null && token != null) {
      setState(() {
        _username = username;
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
      final response = await BackendApi.addAnimal(_token, _username, animal);
      if (response.statusCode == 200) {
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
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: const [
                    Text('Feil'),
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    )
                  ],
                ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          margin: CardStyles.cardPadding,
          shape: const RoundedRectangleBorder(
            borderRadius: CardStyles.cardBorderRadius,
          ),
          elevation: CardStyles.cardElevation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: CardStyles.cardTitlePadding,
                child: Text(
                  'Nytt dyr',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: CardStyles.maxFormWidth,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: CardStyles.formInputFieldPadding,
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
                      padding: CardStyles.formInputFieldPadding,
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
                      padding: CardStyles.formInputFieldPadding,
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
                        Padding(
                          padding: CardStyles.buttonPadding,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                            child: const Padding(
                              padding: CardStyles.buttonTextPadding,
                              child: Text('Avbryt'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: CardStyles.buttonPadding,
                          child: ElevatedButton(
                            onPressed: () {
                              final Animal animal = Animal(
                                name: _nameController.text,
                                species: _speciesController.text,
                                birthday: _selectedDate,
                              );
                              _createAnimal(context, animal);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: const Padding(
                              padding: CardStyles.buttonTextPadding,
                              child: Text('Legg til'),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
