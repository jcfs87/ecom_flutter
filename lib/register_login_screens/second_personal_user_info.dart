import 'package:ecom_app/register_login_screens/third_personal_user_info.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/widgets/custom_text_form.dart';
import 'package:intl/intl.dart';

class SecondPersonalUserInfo extends StatefulWidget {
  const SecondPersonalUserInfo({
    super.key,
    required this.previousEmail,
    required this.previousName,
    required this.previousLastName,
  });

  final String previousEmail;
  final String previousName;
  final String previousLastName;
  @override
  State<SecondPersonalUserInfo> createState() {
    return _SecondPersonalUserInfo();
  }
}

class _SecondPersonalUserInfo extends State<SecondPersonalUserInfo> {
  final _formKey = GlobalKey<FormState>();

  // String type
  var _address = '';
  // String type
  late DateTime birthdate;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    birthdate = DateTime.now();
    super.initState();
  }

  bool isAdult(String birthDateString) {
    String datePattern = "dd-MM-yyyy";

    // Current time - at this moment
    DateTime today = DateTime.now();

    // Parsed date to check
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );

    return adultDate.isBefore(today);
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  void _saveUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return ThirdPersonalUserInfo(
                previousEmail: widget.previousEmail,
                previousName: widget.previousName,
                previousLastName: widget.previousLastName,
                previusAddress: _address,
                previousBirthdate: _dateController.text);
          }),
        );
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '¡Introduce tus datos!',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        // const SizedBox(height: 30),
                        CustomTextForm(
                          hinText: 'Address',
                          textValidator: 'Please enter Address',
                          typeField: 'text',
                          oscuredText: false,
                          prefixIcon: const Icon(Icons.home_outlined),
                          onSaved: (value) {
                            setState(() {
                              _address = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 30),

                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromARGB(77, 232, 228, 228),
                          child: TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              hintText: 'BirthDate',
                              filled: true,
                              prefixIcon: const Icon(Icons.edit_calendar_outlined),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(30, 15, 30, 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 250, 250, 250),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your birthdate';
                              } else if (!isAdult(value)) {
                                return 'You must be at least 18 years old';
                              }
                              return null; // No hay error
                            },
                            onTap: () {
                              _selectDate();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _saveUser,
          shape: const CircleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlue,
          child: const Icon(Icons.arrow_forward),
        ));
  }
}
