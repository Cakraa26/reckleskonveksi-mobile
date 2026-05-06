import 'package:flutter/material.dart';
import '../models/order_model.dart';

// Palet baru: navy + putih bersih + aksen indigo - tegas & profesional
class AppColors {
  static const Color primary = Color(0xFFF8F9FB); // abu putih bersih
  static const Color secondary = Color(0xFFEEF1F6); // abu muda
  static const Color accent = Color(0xFF1E3A8A); // navy biru tua - tegas
  static const Color accentLight = Color(0xFF2D4FA3);
  static const Color accentMid = Color(0xFF3B63C4); // untuk hover/aktif
  static const Color dark = Color(0xFF0F172A); // hampir hitam
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF1F4F9);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color success = Color(0xFF15803D);
  static const Color warning = Color(0xFFB45309);
  static const Color info = Color(0xFF0369A1);
  static const Color purple = Color(0xFF6D28D9);
  static const Color divider = Color(0xFFE2E8F0);
}

class AppRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
}

class AppCredentials {
  static const String email = 'admin@reckles.com';
  static const String password = 'Admin123';
  static const String staffEmail = 'staff@reckles.com';
  static const String staffPassword = 'Staff123';
}

class DummyData {
  static const List<OrderModel> orders = [
    OrderModel(
      id: 'ORD-001',
      clientName: 'PT. Maju Jaya',
      productType: 'Kaos Polo',
      quantity: 500,
      deadline: '20 Jun 2025',
      status: OrderStatus.proses,
      totalPrice: 12500000,
      description: 'Polo shirt bordir logo perusahaan, bahan lacoste CVC',
    ),
    OrderModel(
      id: 'ORD-002',
      clientName: 'SMA Negeri 5',
      productType: 'Seragam Sekolah',
      quantity: 300,
      deadline: '15 Jun 2025',
      status: OrderStatus.selesai,
      totalPrice: 18000000,
      description: 'Seragam putih abu-abu, ukuran S-XL',
    ),
    OrderModel(
      id: 'ORD-003',
      clientName: 'Komunitas BCB',
      productType: 'Jersey Sepeda',
      quantity: 80,
      deadline: '25 Jun 2025',
      status: OrderStatus.pending,
      totalPrice: 6400000,
      description: 'Jersey full print sublimasi, bahan drifit',
    ),
    OrderModel(
      id: 'ORD-004',
      clientName: 'CV. Berkah Tani',
      productType: 'Kemeja Kerja',
      quantity: 150,
      deadline: '30 Jun 2025',
      status: OrderStatus.kirim,
      totalPrice: 9750000,
      description: 'Kemeja lengan panjang bordir nama, bahan oxford',
    ),
    OrderModel(
      id: 'ORD-005',
      clientName: 'Yayasan Peduli Anak',
      productType: 'Kaos Oblong',
      quantity: 1000,
      deadline: '10 Jul 2025',
      status: OrderStatus.proses,
      totalPrice: 15000000,
      description: 'Kaos event charity, sablon plastisol 2 warna',
    ),
    OrderModel(
      id: 'ORD-006',
      clientName: 'PT. Sinar Abadi',
      productType: 'Wearpack Safety',
      quantity: 200,
      deadline: '5 Jul 2025',
      status: OrderStatus.pending,
      totalPrice: 30000000,
      description: 'Wearpack keselamatan kerja standar SNI',
    ),
    OrderModel(
      id: 'ORD-007',
      clientName: 'Kecamatan Lowokwaru',
      productType: 'Batik Seragam',
      quantity: 250,
      deadline: '8 Jul 2025',
      status: OrderStatus.selesai,
      totalPrice: 22500000,
      description: 'Batik print motif khas daerah, lengan panjang',
    ),
    OrderModel(
      id: 'ORD-008',
      clientName: 'Startup Kreatif Co.',
      productType: 'Hoodie',
      quantity: 120,
      deadline: '12 Jul 2025',
      status: OrderStatus.proses,
      totalPrice: 14400000,
      description: 'Hoodie fleece tebal, DTF print chest & back',
    ),
    OrderModel(
      id: 'ORD-009',
      clientName: 'Koperasi Nelayan Maju',
      productType: 'Rompi Nelayan',
      quantity: 75,
      deadline: '18 Jul 2025',
      status: OrderStatus.pending,
      totalPrice: 5625000,
      description: 'Rompi multifungsi bahan ripstop water resistant',
    ),
    OrderModel(
      id: 'ORD-010',
      clientName: 'Band Harmoni',
      productType: 'Kostum Panggung',
      quantity: 6,
      deadline: '22 Jul 2025',
      status: OrderStatus.kirim,
      totalPrice: 3600000,
      description: 'Kostum custom full print, bahan stretch',
    ),
    OrderModel(
      id: 'ORD-011',
      clientName: 'TK Bintang Kecil',
      productType: 'Seragam TK',
      quantity: 180,
      deadline: '28 Jul 2025',
      status: OrderStatus.pending,
      totalPrice: 9000000,
      description: 'Seragam anak TK warna-warni, size 2-6 tahun',
    ),
    OrderModel(
      id: 'ORD-012',
      clientName: 'Klinik Sehat Bersama',
      productType: 'Scrub Medis',
      quantity: 60,
      deadline: '1 Agt 2025',
      status: OrderStatus.proses,
      totalPrice: 7200000,
      description: 'Scrub dokter & perawat, bahan katun anti bakteri',
    ),
  ];
}
