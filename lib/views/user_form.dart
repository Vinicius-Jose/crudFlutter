import 'package:crud/models/user.dart';
import 'package:crud/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['nome'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarurl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context).settings.arguments as User;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuários'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _form.currentState.save();
                Provider.of<Users>(context, listen: false).put(User(
                    id: _formData['id'],
                    name: _formData['nome'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarurl']));
                Navigator.of(context).pop();
              })
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _formData['nome'],
                    decoration: InputDecoration(labelText: 'Nome'),
                    onSaved: (value) => _formData['nome'] = value,
                  ),
                  TextFormField(
                    initialValue: _formData['email'],
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (value) => _formData['email'] = value,
                  ),
                  TextFormField(
                    initialValue: _formData['avatarurl'],
                    decoration: InputDecoration(labelText: 'URL do Avatar'),
                    onSaved: (value) => _formData['avatarurl'] = value,
                  ),
                ],
              ))),
    );
  }
}
