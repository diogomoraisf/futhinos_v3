// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'check_connection_controller.dart';

class CheckConnectionState extends Equatable {
  bool isConnected;
  CheckConnectionState({
    required this.isConnected,
  });
  @override
  List<Object> get props => [isConnected];

  CheckConnectionState copyWith({
    bool? isConnected,
  }) {
    return CheckConnectionState(
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
