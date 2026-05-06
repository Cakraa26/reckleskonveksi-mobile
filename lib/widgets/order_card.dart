import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/order_model.dart';
import '../utils/constants.dart';

// Card item pesanan - digunakan di ListView.builder
class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  // Warna badge status mengikuti alur produksi
  Color get _statusColor {
    switch (order.status) {
      case OrderStatus.pending:
        return const Color(0xFFE65100);
      case OrderStatus.proses:
        return const Color(0xFF1565C0);
      case OrderStatus.selesai:
        return const Color(0xFF2E7D32);
      case OrderStatus.kirim:
        return const Color(0xFF6A1B9A);
    }
  }

  IconData get _statusIcon {
    switch (order.status) {
      case OrderStatus.pending:
        return Icons.hourglass_empty_rounded;
      case OrderStatus.proses:
        return Icons.precision_manufacturing_outlined;
      case OrderStatus.selesai:
        return Icons.check_circle_outline;
      case OrderStatus.kirim:
        return Icons.local_shipping_outlined;
    }
  }

  // Format harga: 12500000 -> Rp 12,5jt
  String get _formattedPrice {
    final price = order.totalPrice;
    if (price >= 1000000) {
      final m = price / 1000000;
      return 'Rp ${m.toStringAsFixed(m.truncateToDouble() == m ? 0 : 1)}jt';
    }
    return 'Rp ${price.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
        // Shadow agar card terlihat mengambang
        boxShadow: [
          BoxShadow(
            color: AppColors.dark.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris atas: ID pesanan + badge status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: GoogleFonts.sourceCodePro(
                    color: AppColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Badge status dengan icon + label
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _statusColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_statusIcon, color: _statusColor, size: 11),
                      const SizedBox(width: 4),
                      Text(
                        order.statusLabel,
                        style: GoogleFonts.inter(
                          color: _statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Nama klien
            Text(
              order.clientName,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              order.description,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            const Divider(color: AppColors.divider, height: 1),
            const SizedBox(height: 10),
            // Baris bawah: info chip + harga
            Row(
              children: [
                _Chip(icon: Icons.style_outlined, label: order.productType),
                const SizedBox(width: 6),
                _Chip(
                  icon: Icons.layers_outlined,
                  label: '${order.quantity} pcs',
                ),
                const Spacer(),
                // Tanggal deadline
                Icon(Icons.event_outlined, size: 12, color: AppColors.textHint),
                const SizedBox(width: 3),
                Text(
                  order.deadline,
                  style: GoogleFonts.inter(
                    color: AppColors.textHint,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Total harga pesanan
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _formattedPrice,
                style: GoogleFonts.inter(
                  color: AppColors.accent,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Chip kecil untuk label info (jenis produk, jumlah)
class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: AppColors.textSecondary),
          const SizedBox(width: 3),
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
