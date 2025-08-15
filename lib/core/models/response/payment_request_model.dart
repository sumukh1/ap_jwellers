import 'package:myapp/core/models/abstracts/response.dart';

class PaymentRequestModel extends Response {
  final int amount;
  final int amountPaid;
  final List<dynamic> notes;
  final int createdAt;
  final int amountDue;
  final String currency;
  final String receipt;
  final String id;
  final String entity;
  final String? offerId;
  final int attempts;
  final String status;

  const PaymentRequestModel({
    required this.amount,
    required this.amountPaid,
    required this.notes,
    required this.createdAt,
    required this.amountDue,
    required this.currency,
    required this.receipt,
    required this.id,
    required this.entity,
    this.offerId,
    required this.attempts,
    required this.status,
  });

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequestModel(
      amount: json['amount'],
      amountPaid: json['amount_paid'],
      notes: json['notes'] ?? [],
      createdAt: json['created_at'],
      amountDue: json['amount_due'],
      currency: json['currency'],
      receipt: json['receipt'],
      id: json['id'],
      entity: json['entity'],
      offerId: json['offer_id'],
      attempts: json['attempts'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [
        amount,
        amountPaid,
        notes,
        createdAt,
        amountDue,
        currency,
        receipt,
        id,
        entity,
        offerId,
        attempts,
        status,
      ];
}
