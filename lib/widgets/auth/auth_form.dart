import 'dart:io';

import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      File userImage, bool isLogin, BuildContext ctx) onSubmit;
  final bool _isLoading;

  AuthForm(this.onSubmit, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _username = '';
  String _userPassword = '';
  File _userImageFile;

  void _imagePickerFn(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus(); // Close keyboard

    if (!_isLogin && _userImageFile == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();

      widget.onSubmit(_userEmail, _userPassword, _username, _userImageFile,
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_imagePickerFn),
                  TextFormField(
                    key: ValueKey('Email'),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value.trim();
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('Username'),
                      textCapitalization: TextCapitalization.words,
                      autocorrect: true,
                      enableSuggestions: false,
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value.trim();
                      },
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value.trim();
                    },
                  ),
                  SizedBox(height: 12.0),
                  RaisedButton(
                    child: widget._isLoading
                        ? SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: CircularProgressIndicator(),
                          )
                        : Text(_isLogin ? 'Login' : 'Signup'),
                    onPressed: widget._isLoading ? null : _trySubmit,
                  ),
                  FlatButton(
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    textColor: theme.primaryColor,
                    onPressed: widget._isLoading
                        ? null
                        : () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
