// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:new_version_plus/new_version_plus.dart';

part 'details_state.g.dart';

@match
enum DetailsStateStatus {
  initial,
  loadingCheckVersion,
  loadingUpdateVersion,
  loadedUpdateVersion,
  loadedCheckVersion,
  openingEmail,
  openedEmail,
  openingReview,
  openedReview,
  openingShare,
  openedShare,
  openingLink,
  openedLink,
  error
}

class DetailsState extends Equatable {
  final DetailsStateStatus status;
  final VersionStatus? versionStatus;
  final String? errorMessage;

  const DetailsState({
    required this.status,
    required this.versionStatus,
    this.errorMessage,
  });

  const DetailsState.initial()
      : status = DetailsStateStatus.initial,
        versionStatus = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, versionStatus, errorMessage];

  DetailsState copyWith({
    DetailsStateStatus? status,
    VersionStatus? versionStatus,
    String? errorMessage,
  }) {
    return DetailsState(
      status: status ?? this.status,
      versionStatus: versionStatus ?? this.versionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
