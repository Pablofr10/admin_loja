import 'package:admin_loja/blocs/login_bloc.dart';
import 'package:admin_loja/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.SUCCESS,
          builder: (context, snapshot){
            print(snapshot.data);
            switch (snapshot.data){
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
              return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.store_mall_directory,
                            color: Colors.pinkAccent, size: 160),
                        InputField(
                          hint: 'Usuário',
                          icon: Icons.person,
                          obscure: false,
                          stream: _loginBloc.outEmail,
                          onChanged: _loginBloc.changeEmail,
                        ),
                        InputField(
                          hint: 'Senha',
                          icon: Icons.vpn_key,
                          obscure: true,
                          stream: _loginBloc.outSenha,
                          onChanged: _loginBloc.changeSenha,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                          height: 50,
                          child: StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValid,
                            builder: (context, snapshot) {
                              return RaisedButton(
                                color: Colors.pinkAccent,
                                child: Text('Entrar'),
                                onPressed: snapshot.hasData? (){} : null,
                                textColor: Colors.white,
                                disabledColor: Colors.pinkAccent.withAlpha(140),
                              );
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
            }            
          }
        ));
  }
}
