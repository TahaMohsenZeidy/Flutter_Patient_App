import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/main.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';

class NewPatient extends StatefulWidget with NavigationStates{
  @override
  State<StatefulWidget> createState() {
    return NewPatientState();
  }
}

class NewPatientState extends State<NewPatient> {
  var currentUser;
  String _name;
  String _history;
  String _symptoms;
  String _medecine;
  String _medical_test;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildHistory() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Medical History',),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'History is required';
        }
      },
      onSaved: (String value) {
        _history = value;
      },
    );
  }

  Widget _buildMedecine() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Medecine',),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Medecine is required';
        }
      },
      onSaved: (String value) {
        _medecine = value;
      },
    );
  }

  Widget _buildSymptoms() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Symptoms'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'symptoms are Required';
        }
        return null;
      },
      onSaved: (String value) {
        _symptoms = value;
      },
    );
  }


  Widget _buildMedicalTest() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Medical Tests'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Medical Tests Required';
        }

        return null;
      },
      onSaved: (String value) {
        _medical_test = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 40.0, top: 70.0, right: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildHistory(),
                _buildSymptoms(),
                _buildMedicalTest(),
                _buildMedecine(),
                SizedBox(height: 60),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    'Add New Patient',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                    }
                    _formKey.currentState.save();

                    var currentPatientId = '5BqPNpfgxpJ0U5zWNOr';

                    // patientsRef.get().then((QuerySnapshot querySnapshot) {
                    //   querySnapshot.docs.forEach((doc) {
                    //     print(doc.id);
                    //   });
                    // });

                    patientsRef.doc(currentPatientId).set({
                      "Medical History": _history,
                      "symptoms": _symptoms,
                      "MedicalTest":_medical_test,
                    });

                    //Send to API
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
