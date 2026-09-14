class Transaction {
  final String id;
  final double amount;
  final String categoryId;
  final String note;
  final DateTime date;

  Transaction({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.note,
    required this.date,
  });
}
