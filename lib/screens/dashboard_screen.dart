import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/app_state.dart';
import '../models/order_model.dart';
import '../widgets/order_card.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // state: tab aktif bottom navigation
  String _filterStatus = 'Semua'; // state: filter pesanan di tab Pesanan

  final List<String> _filterOptions = [
    'Semua',
    'Pending',
    'Diproses',
    'Selesai',
    'Dikirim',
  ];

  // Getter pesanan yang difilter berdasarkan status
  List<OrderModel> get _filteredOrders {
    if (_filterStatus == 'Semua') return DummyData.orders;
    return DummyData.orders
        .where((o) => o.statusLabel == _filterStatus)
        .toList();
  }

  // Dialog konfirmasi sebelum logout
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Konfirmasi Logout',
          style: GoogleFonts.barlow(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar?',
          style: GoogleFonts.inter(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Batal',
              style: GoogleFonts.inter(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Reset state user di InheritedWidget
              AppState.of(context)?.setUser(null);
              // Hapus semua route, kembali ke login
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (r) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── TAB 1: HOME ──────────────────────────────────────────────
  Widget _buildHomeTab() {
    final user = AppState.of(context)?.currentUser;

    // Hitung statistik dari data dummy
    final pendingCount = DummyData.orders
        .where((o) => o.status == OrderStatus.pending)
        .length;
    final prosesCount = DummyData.orders
        .where((o) => o.status == OrderStatus.proses)
        .length;
    final selesaiCount = DummyData.orders
        .where((o) => o.status == OrderStatus.selesai)
        .length;
    final kirimCount = DummyData.orders
        .where((o) => o.status == OrderStatus.kirim)
        .length;
    final totalRevenue = DummyData.orders
        .where((o) => o.status == OrderStatus.selesai)
        .fold<double>(0, (sum, o) => sum + o.totalPrice);
    final revenueStr = 'Rp ${(totalRevenue / 1000000).toStringAsFixed(0)}jt';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // ── KARTU SAMBUTAN USER ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(18),
              // BoxShadow untuk efek kedalaman kartu
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                // Avatar inisial user
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user?.avatarInitial ?? 'U',
                      style: GoogleFonts.barlow(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang,',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      // Data nama user dari state InheritedWidget
                      Text(
                        user?.name ?? 'User',
                        style: GoogleFonts.barlow(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${DummyData.orders.length}',
                      style: GoogleFonts.barlow(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Total Pesanan',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'STATISTIK PESANAN',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // ── GRID 4 STAT CARD ── (GridView dengan shrinkWrap)
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.15,
            children: [
              StatCard(
                title: 'Pending',
                value: '$pendingCount',
                icon: Icons.hourglass_empty_rounded,
                color: AppColors.warning,
                subtitle: 'Menunggu proses',
              ),
              StatCard(
                title: 'Diproses',
                value: '$prosesCount',
                icon: Icons.precision_manufacturing_outlined,
                color: AppColors.info,
                subtitle: 'Sedang dikerjakan',
              ),
              StatCard(
                title: 'Selesai',
                value: '$selesaiCount',
                icon: Icons.check_circle_outline,
                color: AppColors.success,
                subtitle: 'Siap dikirim',
              ),
              StatCard(
                title: 'Dikirim',
                value: '$kirimCount',
                icon: Icons.local_shipping_outlined,
                color: const Color(0xFF6A1B9A),
                subtitle: 'Dalam pengiriman',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Kartu total pendapatan - Card dengan rounded corner & shadow
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.divider),
              boxShadow: [
                BoxShadow(
                  color: AppColors.dark.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.payments_outlined,
                    color: AppColors.success,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pendapatan',
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      revenueStr,
                      style: GoogleFonts.inter(
                        color: AppColors.success,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  'dari order\nselesai',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    color: AppColors.textHint,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PESANAN TERBARU',
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              TextButton(
                onPressed: () =>
                    setState(() => _selectedIndex = 1), // pindah ke tab Pesanan
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Text(
                  'Lihat semua',
                  style: GoogleFonts.inter(
                    color: AppColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ListView 5 pesanan terbaru - menggunakan ListView.builder
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) =>
                OrderCard(order: DummyData.orders[index]),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ── TAB 2: DAFTAR PESANAN ────────────────────────────────────
  Widget _buildOrdersTab() {
    return Column(
      children: [
        // Filter chip horizontal scroll
        Container(
          color: AppColors.primary,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filterOptions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final isSelected = _filterStatus == _filterOptions[i];
                return GestureDetector(
                  // setState untuk mengubah filter aktif
                  onTap: () =>
                      setState(() => _filterStatus = _filterOptions[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.accent : AppColors.cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accent
                            : AppColors.divider,
                      ),
                    ),
                    child: Text(
                      _filterOptions[i],
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Text(
                '${_filteredOrders.length} pesanan ditemukan',
                style: GoogleFonts.inter(
                  color: AppColors.textHint,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        // ListView.builder menampilkan semua pesanan yang difilter
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 6, bottom: 24),
            itemCount: _filteredOrders.length,
            itemBuilder: (ctx, i) => OrderCard(order: _filteredOrders[i]),
          ),
        ),
      ],
    );
  }

  // ── TAB 3: PROFIL USER ───────────────────────────────────────
  Widget _buildProfileTab() {
    final user = AppState.of(context)?.currentUser;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Avatar besar dengan initial user
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                user?.avatarInitial ?? 'U',
                style: GoogleFonts.barlow(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            user?.name ?? '-',
            style: GoogleFonts.barlow(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            user?.email ?? '-',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accent.withOpacity(0.3)),
            ),
            child: Text(
              user?.role ?? '-',
              style: GoogleFonts.inter(
                color: AppColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 28),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 20),

          // Info rows menggunakan widget _ProfileInfoRow
          _ProfileInfoRow(
            icon: Icons.business_outlined,
            label: 'Perusahaan',
            value: 'Reckles Konveksi',
          ),
          const SizedBox(height: 10),
          _ProfileInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Lokasi',
            value: 'Denpasar, Bali',
          ),
          const SizedBox(height: 10),
          _ProfileInfoRow(
            icon: Icons.phone_outlined,
            label: 'Telepon',
            value: '+62 812-3456-7890',
          ),
          const SizedBox(height: 10),
          _ProfileInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Bergabung',
            value: 'Januari 2024',
          ),

          const SizedBox(height: 32),

          // Tombol logout di tab profil
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _showLogoutDialog,
              icon: const Icon(Icons.logout, size: 18),
              label: Text(
                'Logout',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Daftar tab sesuai index bottom navigation
    final List<Widget> tabs = [
      _buildHomeTab(),
      _buildOrdersTab(),
      _buildProfileTab(),
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      // AppBar dengan judul + tombol logout (Icons.logout)
      appBar: AppBar(
        backgroundColor: AppColors.cardBg,
        elevation: 0,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: AppColors.divider),
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.content_cut,
                color: Colors.white,
                size: 17,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Reckles Konveksi',
              style: GoogleFonts.barlow(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          // Tombol logout di AppBar sesuai spesifikasi
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.accent, size: 22),
            tooltip: 'Logout',
            onPressed: _showLogoutDialog,
          ),
        ],
      ),

      // Body menampilkan tab sesuai _selectedIndex
      body: tabs[_selectedIndex],

      // Bottom Navigation Bar dengan 3 tab
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.textHint,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reusable untuk baris info profil
class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 19),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: AppColors.textHint,
                  fontSize: 11,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
