import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/models/person.dart';

class AddPersonForm extends StatefulWidget {
  const AddPersonForm({Key? key}) : super(key: key);

  @override
  _AddPersonFormState createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _howController = TextEditingController();
  final _whenController = TextEditingController();
  final _revengeController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();

  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Add info to people box
  _addInfo() async {
    Person newPerson = Person(
        name: _nameController.text,
        surname: _surnameController.text,
        how: _howController.text,
        when: _whenController.text,
        revenge: _revengeController.text
    );

    box.add(newPerson);
    print('Info added to box!');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('peopleBox');
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
                      _addInfo();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
