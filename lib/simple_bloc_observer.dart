import 'dart:ffi';
import 'dart:html';

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  Void onEvent (Bloc bloc, Object event){
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(Cubit cubit , object error, StackTrace stackTrace){
    print(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(Cubit cubit, Change change){
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition){
    print(transition);
    super.onChange(bloc, transition);
  }

}