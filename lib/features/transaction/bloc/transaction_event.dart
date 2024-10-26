part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionLoadData extends TransactionEvent {}

class TransactionRequestForm extends TransactionEvent {
  final TransactionRequestBodyModel body;

  const TransactionRequestForm({
    required this.body,
  });

  @override
  List<Object> get props => [
        body,
      ];
}

// class SearchDataDefect extends TransactionEvent {
//   final String searchKey;

//   const SearchDataDefect({
//     required this.searchKey,
//   });

//   @override
//   List<Object> get props => [
//         searchKey,
//       ];
// }

// class SendDataTransaction extends TransactionEvent {
//   final TransactionRequestModel bodyTransaction;

//   const SendDataTransaction({
//     required this.bodyTransaction,
//   });

//   @override
//   List<Object> get props => [
//         bodyTransaction,
//       ];
// }

// class UpdateStatusTransaction extends TransactionEvent {
//   final int transactionId;
//   final String statusTransaction;

//   const UpdateStatusTransaction({
//     required this.transactionId,
//     required this.statusTransaction,
//   });

//   @override
//   List<Object> get props => [
//         transactionId,
//         statusTransaction,
//       ];
// }

// class UpdateFixedBiayaPajakTransaction extends TransactionEvent {
//   final int transactionId;
//   final String fixedBiayaPajak;

//   const UpdateFixedBiayaPajakTransaction({
//     required this.transactionId,
//     required this.fixedBiayaPajak,
//   });

//   @override
//   List<Object> get props => [
//         transactionId,
//         fixedBiayaPajak,
//       ];
// }

// class DeleteDataTransaction extends TransactionEvent {
//   final int transactionId;

//   const DeleteDataTransaction({
//     required this.transactionId,
//   });

//   @override
//   List<Object> get props => [
//         transactionId,
//       ];
// }

class SetStatusToInitial extends TransactionEvent {}
