// Enum status pesanan - mengikuti alur produksi konveksi
enum OrderStatus { pending, proses, selesai, kirim }

// Model data pesanan konveksi
class OrderModel {
  final String id;
  final String clientName;
  final String productType;
  final int quantity;
  final String deadline;
  final OrderStatus status;
  final double totalPrice;
  final String description;

  const OrderModel({
    required this.id,
    required this.clientName,
    required this.productType,
    required this.quantity,
    required this.deadline,
    required this.status,
    required this.totalPrice,
    required this.description,
  });

  // Getter label status dalam bahasa Indonesia
  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.proses:
        return 'Diproses';
      case OrderStatus.selesai:
        return 'Selesai';
      case OrderStatus.kirim:
        return 'Dikirim';
    }
  }
}
