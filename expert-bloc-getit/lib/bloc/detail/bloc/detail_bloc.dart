import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundamental_recap/service/api_service.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ApiService apiService;
  DetailBloc({
    required this.apiService,
  }) : super(DetailInitial()) {
    on<DetailDogBreed>((event, emit) async {
      try {
        emit(
          DetailLoading(),
        );
        final breed = event.breed;
        final result = await apiService.dogBreed(breed);

        if (result.status == "success") {
          emit(
            DetailLoaded(result.message, result.status),
          );
        } else {
          emit(
            DetailNoData(result.status),
          );
        }
      } catch (e) {
        emit(
          DetailError(e.toString()),
        );
      }
    });
  }
}
