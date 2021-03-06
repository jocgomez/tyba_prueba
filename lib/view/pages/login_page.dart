import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tyba_prueba/controller/auth.dart';
import 'package:tyba_prueba/view/components/button_Component.dart';
import 'package:tyba_prueba/view/utils/globals.dart';
import 'package:tyba_prueba/view/utils/style.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordInvisible = true, _isRegisterClicked = false;
  TextEditingController _emailController = new TextEditingController(),
      _passController = new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StylesElements.colorGreyBG,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  child: Image.asset('assets/logo.png'),
                  margin: EdgeInsets.all(20),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                elevation: 10,
                shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            // Campo de texto para el email con validaci??n de contenido y estructura
                            emailTextField(),
                            SizedBox(height: 20.0),
                            // Campo de texto para la contrase??a con opci??n de visualizaci??n
                            passwordTextField(),
                            SizedBox(height: 20.0),
                            // Bot??n para registrar o ingresar
                            registerLoginButton(),
                            // Opciones para cambiar entre registro e ingreso
                            registerLoginOptions()
                          ]))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        // Se valida que tenga un email
        if (value.isEmpty) {
          return 'Escriba un email.';
        }
        // Valida que tenga una estructura el email
        if (!EmailValidator.validate(value)) {
          return 'Email inv??lido.';
        }

        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      inputFormatters: [
        BlacklistingTextInputFormatter(" "),
      ],
      // Decoraci??n del campo de texto
      decoration: StylesElements.textFieldDecoration("Email", true, Globals.strEmailIcon, () {}),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      controller: _passController,
      validator: (value) {
        // Se valida que tenga una contrase??a
        if (value.isEmpty) {
          return 'Escriba una contrase??a.';
        }
        return null;
      },
      keyboardType: TextInputType.visiblePassword,
      obscureText: _isPasswordInvisible,
      textCapitalization: TextCapitalization.none,
      // Decoraci??n del campo de texto
      decoration: StylesElements.textFieldDecoration("Contrase??a", true,
          _isPasswordInvisible ? Globals.strPasswordIconInvisible : Globals.strPasswordIconVisible,
          () {
        setState(() {
          _isPasswordInvisible = !_isPasswordInvisible;
        });
      }),
    );
  }

  Widget registerLoginButton() {
    return ButtonComponent(
        color: StylesElements.colorPrimary,
        text: _isRegisterClicked ? "Registrarte" : "Iniciar sesi??n",
        borderColor: StylesElements.colorPrimary,
        function: () {
          // Se valida que los campos no se encuentren vacios
          if (_formKey.currentState.validate()) {
            String _email = _emailController.text;
            String _pass = _passController.text;

            // Se registra o se ingresa segun sea el caso
            if (_isRegisterClicked) {
              Auth().register(_email, _pass, context);
            } else {
              Auth().signIn(_email, _pass, context);
            }
          }
        });
  }

  Widget registerLoginOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _isRegisterClicked ? "Si ya tienes una cuenta, " : "Si a??n no tienes cuenta, ",
          style: TextStyle(color: StylesElements.colorBlack),
        ),
        FlatButton(
            onPressed: () {
              setState(() {
                _isRegisterClicked = !_isRegisterClicked;
              });
            },
            child: Text(_isRegisterClicked ? "ingresa aqu??" : "registrate aqu??",
                style:
                    TextStyle(color: StylesElements.colorSecondary, fontWeight: FontWeight.bold)))
      ],
    );
  }
}
