import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Registration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegistrationFormPage(title: 'User Registration Page'),
    );
  }
}

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({super.key, required this.title});
  final String title;

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState<String>>();
  final _emailKey = GlobalKey<FormFieldState<String>>();
  final _passwordKey = GlobalKey<FormFieldState<String>>();
  String _gender = '';
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
              ),
              TextFormField(
                key: _nameKey,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                  key: _emailKey,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
              TextFormField(
                key: _passwordKey,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    const Text('Gender:'),
                    Radio(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value.toString();
                          });
                        }),
                    const Text('Male'),
                    Radio(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value.toString();
                          });
                        }),
                    const Text('Female'),
                  ],
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      }),
                  const Text('I accept the terms and conditions')
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_gender.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please select a gender'),
                                ));
                        return;
                      }

                      if (!_termsAccepted) {
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                  title: Text('Error'),
                                  content: Text(
                                      'Please accept the terms and conditions'),
                                ));
                        return;
                      }

                      // Print form field values
                      if (kDebugMode) {
                        print('Name: ${_nameKey.currentState?.value}');
                        print('Email: ${_emailKey.currentState?.value}');
                        print('Password: ${_passwordKey.currentState?.value}');
                        print('Gender: $_gender');
                        print('Terms Accepted: $_termsAccepted');
                      }

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Success'),
                                content: const Text(
                                    'Your registration was successful'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        _formKey.currentState?.reset();
                                        setState(() {
                                          _gender = '';
                                          _termsAccepted = false;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'))
                                ],
                              ));
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
