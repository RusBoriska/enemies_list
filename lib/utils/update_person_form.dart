import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '/models/person.dart';

class UpdatePersonForm extends StatefulWidget {
  final int index;
  final Person person;

  const UpdatePersonForm({
    required this.index,
    required this.person,
  });

  @override
  _UpdatePersonFormState createState() => _UpdatePersonFormState();
}

class _UpdatePersonFormState extends State<UpdatePersonForm> {
  final _personFormKey = GlobalKey<FormState>();

  late final _nameController;
  late final _surnameController;
  late final _howController;
  late final _whenController;
  late final _revengeController;

  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Update info of people box
  _updateInfo() {
    Person newPerson = Person(
        name: _nameController.text,
        surname: _surnameController.text,
        how: _howController.text,
        when: _whenController.text,
        revenge: _revengeController.text
    );

    box.putAt(widget.index, newPerson);

    print('Info updated in box!');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('peopleBox');
    _nameController = TextEditingController(text: widget.person.name);
    _surnameController = TextEditingController(text: widget.person.surname);
    _howController = TextEditingController(text: widget.person.how);
    _whenController = TextEditingController(text: widget.person.when);
    _revengeController = TextEditingController(text: widget.person.revenge);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _personFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextFormField(
              controller: _nameController,
              validator: _fieldValidator,
            ),
            SizedBox(height: 24.0),
            Text('Surname'),
            TextFormField(
              controller: _surnameController,
              validator: _fieldValidator,
            ),
            SizedBox(height: 24.0),
            Text('How he/she offended me'),
            TextFormField(
              controller: _howController,
              validator: _fieldValidator,
            ),
            SizedBox(height: 24.0),
            Text('When he/she offended me'),
            TextFormField(
              controller: _whenController,
              validator: _fieldValidator,
            ),
            SizedBox(height: 24.0),
            Text('My revenge on him/her'),
            TextFormField(
              controller: _revengeController,
              validator: _fieldValidator,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
              child: Container(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_personFormKey.currentState!.validate()) {
                      _updateInfo();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Update'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
