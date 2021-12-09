import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/repository/autentication/authentication.dart';



class App extends StatelessWidget{
  const app({
    Key key,
    @required this.authenticationRepository
  }) : assert(authenticationRepository != null),
    super(key: key);

    final AuthenticationRepository authenticationRepository;

    @override
    Widget build(BuildContext context){
      return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(),
          child: AppView(),
        ),
      );
    }
}

class AppView extends StatefulWidget{
  @overrride
  _AppViewState createstate() => _AppViewState();
}
class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: theme,
      navigatorkey: _navigatorKey,
      builder: (context, child){
        return BlocListener(listener: (context, state){

        });//Bloc listener
      }
    );// material app
  }

}

