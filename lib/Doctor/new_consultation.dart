import 'package:flutter/material.dart';
import 'package:patient_app/Doctor/AddTests.dart';
import 'package:patient_app/Doctor/src/AddMedecine.dart';
import 'package:patient_app/main.dart';
import 'bloc.navigation_bloc/navigation_bloc.dart';


class NewConsultation extends StatefulWidget with NavigationStates {
  @override
  State<StatefulWidget> createState() {
    return NewConsultationState();
  }
}

class NewConsultationState extends State<NewConsultation> {
  var currentUser;
  String _symptoms;
  String _gen_feeling;
  String _health_concerns;
  String _additional_inputs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Widget _buildGeneralFeeling() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'General Feeling'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'General feeling are required';
        }
        return null;
      },
      onSaved: (String value) {
        _gen_feeling = value;
      },
    );
  }

  Widget _buildHealthConcerns() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Health Concerns'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Health concerns are required';
        }
        return null;
      },
      onSaved: (String value) {
        _health_concerns = value;
      },
    );
  }

  Widget _buildAdditionalInputs() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Additional Inputs'),
      maxLength: 100,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Additional inputs are required';
        }
        return null;
      },
      onSaved: (String value) {
        _additional_inputs = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Consultation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 40.0, top: 10.0, right: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Mr Patient Patient",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, height: 2,color: Colors.blueAccent),),
                _buildSymptoms(),
                _buildGeneralFeeling(),
                _buildHealthConcerns(),
                _buildAdditionalInputs(),
                SizedBox(height: 60),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Add Tests',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddDisease(),
                      ),
                    ),
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Add Medecine',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MedicineReminder(),
                      ),
                    ),
                  },
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Finalise Consultation',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {}
                    _formKey.currentState.save();

                    // var currentPatientId = '5BqPNpfgxpJ0U5zWNOr';
                    // patientsRef.doc(currentPatientId).set({
                    //   "Medical History": _history,
                    //   "symptoms": _symptoms,
                    //   "MedicalTest": _medical_test,
                    // });
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
