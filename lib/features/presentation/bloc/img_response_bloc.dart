import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/front_tooth_class.dart';
import '../../domain/usecases/left_tooth_class.dart';
import '../../domain/usecases/lower_tooth_class.dart';
import '../../domain/usecases/right_tooth_class.dart';
import '../../domain/usecases/upper_tooth_class.dart';

part 'img_response_event.dart';
part 'img_response_state.dart';

class ImgResponseBloc extends Bloc<ImgResponseEvent, ImgResponseState> {
  final FrontImageResponse _frontClassification;
  final RightImageResponse _rightClassification;
  final LeftImageResponse _leftClassification;
  final UpperImageResponse _upperClassification;
  final LowerImageResponse _lowerClassification;

  ImgResponseBloc(
    this._frontClassification,
    this._rightClassification,
    this._leftClassification,
    this._upperClassification,
    this._lowerClassification,
  ) : super(ImgResponseInitial()) {
    on<OnCombinedImgResponse>((event, emit) async {
      emit(ImgResponseLoading());

      final frontResult = await _frontClassification.execute(event.frontImage);
      final rightResult = await _rightClassification.execute(event.rightImage);
      final leftResult = await _leftClassification.execute(event.leftImage);
      final upperResult = await _upperClassification.execute(event.upperImage);
      final lowerResult = await _lowerClassification.execute(event.lowerImage);

      if (frontResult.isLeft()) {
        emit(ImgResponseError(
            frontResult.fold((failure) => failure.message, (_) => '')));
        return;
      }
      if (rightResult.isLeft()) {
        emit(ImgResponseError(
            rightResult.fold((failure) => failure.message, (_) => '')));
        return;
      }
      if (leftResult.isLeft()) {
        emit(ImgResponseError(
            leftResult.fold((failure) => failure.message, (_) => '')));
        return;
      }
      if (upperResult.isLeft()) {
        emit(ImgResponseError(
            upperResult.fold((failure) => failure.message, (_) => '')));
        return;
      }
      if (lowerResult.isLeft()) {
        emit(ImgResponseError(
            lowerResult.fold((failure) => failure.message, (_) => '')));
        return;
      }

      emit(CombinedImgResponseState(
        frontImgUint8List: frontResult.getOrElse(() => Uint8List(0)),
        rightImgUint8List: rightResult.getOrElse(() => Uint8List(0)),
        leftImgUint8List: leftResult.getOrElse(() => Uint8List(0)),
        upperImgUint8List: upperResult.getOrElse(() => Uint8List(0)),
        lowerImgUint8List: lowerResult.getOrElse(() => Uint8List(0)),
      ));
    });
  }
}
