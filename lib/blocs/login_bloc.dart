import 'package:admin_loja/validators/login_validators.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with LoginValidators{

  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outSenha => _senhaController.stream.transform(validateSenha);

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
    outEmail, outSenha, (a, b) => true
    );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeSenha => _senhaController.sink.add;



  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
  }

}