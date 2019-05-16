import 'package:flutter/material.dart';

enum FormMode { LOGIN, SIGNUP }

class LoginSignUpPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _LoginSignUpPageState();
  }
}

class _LoginSignUpPageState extends State<LoginSignUpPage>{
  
  final _formKey = new GlobalKey<FormState>();
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos = false;
  bool _isLoading = false;

  String _email;
  String _password;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress(),
        ],
      )
    );
  }

  Widget _showCircularProgress(){
    if(_isLoading) {
      return Center(
        child: CircularProgressIndicator()
      );
    } else {
      return Container(height: 0, width: 0,);
    }
  }

  Widget _showLogo() {
    return new Hero(
        tag: "Hero",
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48,
            child: Image.asset("assets/retroapp-icon.png"),
          ),
        )
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          )
        ),
        validator: (value) => value.isEmpty ? "Email cannot be empty" : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: new TextFormField(
            maxLines: 1,
            obscureText: true,
            autofocus: false,
            decoration: new InputDecoration(
                hintText: 'Password',
                icon: new Icon(
                  Icons.lock,
                  color: Colors.grey,
                )
            ),
            validator: (value) => value.isEmpty ? "Password cannot be empty" : null,
            onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
      child: new MaterialButton(
          elevation: 5,
          minWidth: 200,
          height: 42,
          color: Colors.blue,
          child: new Text(
            FormMode.LOGIN == _formMode ? "Login": "Create Account",
            style: new TextStyle(fontSize: 20, color: Colors.white),
          ),
          onPressed: _validateAndSubmit
      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
        child: new Text(
          FormMode.LOGIN == _formMode ? "Create an account": "Have an account? Sign in",
          style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        onPressed: FormMode.LOGIN == _formMode
            ? _changeFormToSignUp
            : _changeFormToLogin,
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showBody(){
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
//    if (_validateAndSave()) {
//      String userId = "";
//      try {
//        if (_formMode == FormMode.LOGIN) {
//          userId = await widget.auth.signIn(_email, _password);
//          print('Signed in: $userId');
//        } else {
//          userId = await widget.auth.signUp(_email, _password);
//          print('Signed up user: $userId');
//        }
//        if (userId.length > 0 && userId != null) {
//          widget.onSignedIn();
//        }
//      } catch (e) {
//        print('Error: $e');
//        setState(() {
//          _isLoading = false;
//          if (_isIos) {
//            _errorMessage = e.details;
//          } else
//            _errorMessage = e.message;
//        });
//      }
//    }
  }
}

