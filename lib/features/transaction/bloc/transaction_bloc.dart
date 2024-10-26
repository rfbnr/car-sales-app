import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/datasources/transaction_remote_datasource.dart';
import '../../../data/models/request/transaction_request_body_model.dart';
import '../../../data/models/response/error_response_model.dart';
import '../../../data/models/response/success_response_model.dart';
import '../../../data/models/response/transaction_response_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRemoteDatasource transactionRemoteDatasource;

  TransactionBloc({
    required this.transactionRemoteDatasource,
  }) : super(const TransactionState()) {
    on<TransactionRequestForm>(_onTransactionRequestForm);
    on<TransactionLoadData>(_onTransactionLoadData);

    on<SetStatusToInitial>(_onSetStatusToInitial);
  }

  Future<void> _onSetStatusToInitial(
    SetStatusToInitial event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: TransactionStatus.initial,
      ),
    );
  }

  Future<void> _onTransactionLoadData(
    TransactionLoadData event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: TransactionStatus.loading,
      ),
    );

    try {
      final response = await transactionRemoteDatasource.getTransactionByUser();

      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: TransactionStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: TransactionStatus.success,
              transaction: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.failure,
          error: ErrorResponseModel(
            status: 404,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  // Future<void> _onLoadTransactionByUser(
  //   LoadTransactionByUser event,
  //   Emitter<TransactionState> emit,
  // ) async {
  //   emit(
  //     state.copyWith(
  //       status: TransactionStatus.loading,
  //     ),
  //   );

  //   try {
  //     final response =
  //         await transactionRemoteDatasource.getDataTransactionByUser(
  //       userId: event.userId,
  //     );

  //     response.fold(
  //       (l) {
  //         emit(
  //           state.copyWith(
  //             status: TransactionStatus.failure,
  //             error: l,
  //           ),
  //         );
  //       },
  //       (r) {
  //         emit(
  //           state.copyWith(
  //             status: TransactionStatus.success,
  //             dataTransaction: r,
  //           ),
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         status: TransactionStatus.failure,
  //         error: ErrorResponseModel(
  //           status: "error",
  //           message: e.toString(),
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> _onTransactionRequestForm(
    TransactionRequestForm event,
    Emitter<TransactionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: TransactionStatus.loading,
      ),
    );

    try {
      final response = await transactionRemoteDatasource.transactionRequestForm(
        transactionRequestModel: event.body,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(
              status: TransactionStatus.failure,
              error: l,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: TransactionStatus.success,
              success: r,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionStatus.failure,
          error: ErrorResponseModel(
            status: 404,
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
