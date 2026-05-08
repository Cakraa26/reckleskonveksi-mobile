// Enum status pesanan - mengikuti alur produksi konveksi
enum OrderStatus { pending, proses, selesai, kirim }

// Model data pesanan konveksi
class OrderModel {
  final String id; // ID untuk setiap pesanan
  final String clientName; // Nama pelanggan
  final String productType; // Jenis produk. Contoh: Kaos, Hoodie
  final int quantity; // Jumlah barang yang dipesan
  final String deadline; // Batas waktu penyelesaian pesanan
  final OrderStatus status; // Status pesanan menggunakan enum OrderStatus
  final double totalPrice; // Total harga keseluruhan pesanan
  final String description; // Deskripsi tambahan. Contoh: warna, jenis sablon

  // required saat membuat object
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
    switch (status) { // cek status
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
