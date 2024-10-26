part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, failure }

class TransactionState extends Equatable {
  final TransactionStatus status;
  final TransactionResponseModel? transaction;
  final ErrorResponseModel? error;
  final SuccessResponseModel? success;

  const TransactionState({
    this.status = TransactionStatus.initial,
    this.transaction,
    this.success,
    this.error,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    TransactionResponseModel? transaction,
    ErrorResponseModel? error,
    SuccessResponseModel? success,
  }) {
    return TransactionState(
      status: status ?? this.status,
      transaction: transaction ?? this.transaction,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        transaction,
        success,
        error,
      ];
}
