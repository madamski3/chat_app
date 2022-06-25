import 'package:flutter/material.dart';
import '../../pickers/image_selector.dart';

class AuthForm extends StatefulWidget {
  final bool _isLoading;
  final void Function(
    String emailAddress,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) _submitAuth;

  const AuthForm(this._submitAuth, this._isLoading, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoginMode = false;
  String? _userEmail = '';
  String? _userName = '';
  String? _userPassword = '';

  void _submitForm() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus(); // Closes the keyboard

    if (isValid != null && isValid) {
      _formkey.currentState!.save();
      widget._submitAuth(
        _userEmail!,
        _userName!,
        _userPassword!,
        _isLoginMode,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLoginMode) ImageSelector(),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email address'),
                  ),
                  if (!_isLoginMode)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 4) {
                          return 'Please choose a username with at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Please choose a password with at least 7 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: _isLoginMode ? const Text('Login') : const Text('Sign Up'),
                    ),
                  if (!widget._isLoading)
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _isLoginMode = !_isLoginMode;
                        });
                      },
                      child: _isLoginMode ? const Text('Create new account') : const Text('Have an account? Login'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
