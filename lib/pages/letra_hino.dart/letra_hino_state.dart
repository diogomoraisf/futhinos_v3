// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'letra_hino_state.g.dart';

@match
enum LetraHinoStateStatus { initial, loading, loaded, error }

class LetraHinoState extends Equatable {
  final LetraHinoStateStatus status;
  final String letraHino;
  final String? errorMessage;
  const LetraHinoState({
    required this.status,
    required this.letraHino,
    this.errorMessage,
  });

  const LetraHinoState.initial()
      : status = LetraHinoStateStatus.initial,
        letraHino = '',
        errorMessage = null;
  @override
  List<Object?> get props => [status, letraHino, errorMessage];

  LetraHinoState copyWith({
    LetraHinoStateStatus? status,
    String? letraHino,
    String? errorMessage,
  }) {
    return LetraHinoState(
      status: status ?? this.status,
      letraHino: letraHino ?? this.letraHino,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
