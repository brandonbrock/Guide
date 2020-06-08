import 'package:flutter/material.dart';
import 'package:guide/models/user.dart';
import 'package:guide/authenticate/login.dart';
import 'package:guide/services/auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {

    final Function toggleView;
  RegisterPage({ this.toggleView });

  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String displayName = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child:LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportContraints) {
          return Container (
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportContraints.maxHeight,
            ),
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //header
                Text(
                  'Create an Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                      return 'Display Name is required';
                      }
                    if (input.length < 5 || input.length > 10) {
                      return 'Display Name must be betweem 5 and 10 characters';
                    }
                  return null;
                  },
                  onChanged: (input) {
                  setState(() => displayName = input);
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Display Name',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                    return 'Email can\'t be empty';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                  },
                  onChanged: (input) {
                  setState(() => email = input);
                  },
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                    return 'Password can\'t be empty';
                  }
                  if (input.length < 5 || input.length > 15) {
                    return 'Password must be between 5 and 15 characters';
                  }
                  return null;
                  },
                  onChanged: (input) {
                  setState(() => password = input);
                  },
                  obscureText: true,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (String input) {
                    if (input.isEmpty) {
                    return 'Password can\'t be empty';
                  }
                  return null;
                  },
                  obscureText: true,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Confirm Password',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 20,),
                FlatButton(child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  textColor: Colors.white,
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;

                        AlertDialog(
        title: Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Please enter details correctly'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );                        
                      });
                    }
                  }
                  }
                ),
                SizedBox(height: 12.0),
                FlatButton(child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  textColor: Colors.white,
                  onPressed: () => widget.toggleView(),
                ),
            ],
            ),
          ),
        ),
      );
        },
        ) 
      ),
    );
  }


}