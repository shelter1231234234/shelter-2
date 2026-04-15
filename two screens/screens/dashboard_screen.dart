import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/shared_widgets.dart';
import 'card_settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Credit Card ──────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CardSettingsScreen(),
                          ),
                        ),
                        child: const CreditCardWidget(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CardDotsIndicator(count: 3, active: 0),
                    const SizedBox(height: 28),

                    // ── Quick Actions ────────────────────────
                    _sectionTitle('Quick Actions'),
                    const SizedBox(height: 14),
                    _buildQuickActions(),
                    const SizedBox(height: 28),

                    // ── Services ─────────────────────────────
                    _sectionTitle('Services'),
                    const SizedBox(height: 14),
                    _buildServices(),
                    const SizedBox(height: 28),

                    // ── Schedule Payments ─────────────────────
                    _buildScheduleHeader(),
                    const SizedBox(height: 14),
                    _buildPaymentsList(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            AppBottomNav(selectedIndex: 0),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kPaddingH, 16, kPaddingH, 12),
      child: Row(
        children: [
          // Avatar with online dot
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimary.withOpacity(0.3), width: 2),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://i.pravatar.cc/150?img=12',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759),
                    shape: BoxShape.circle,
                    border: Border.all(color: kWhite, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: Center(
              child: Text('Fintech', style: kStyleHeading),
            ),
          ),
          const NotificationBell(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      _ActionData(
        icon: Icons.swap_horiz_rounded,
        label: 'Money Transfer',
        iconColor: kGreenAccent,
        bgColor: kGreenLight,
      ),
      _ActionData(
        icon: Icons.receipt_long_rounded,
        label: 'Pay Bill',
        iconColor: const Color(0xFF6C63FF),
        bgColor: const Color(0xFFEEEDFF),
      ),
      _ActionData(
        icon: Icons.account_balance_outlined,
        label: 'Bank to Bank',
        iconColor: kTextGrey,
        bgColor: kBackground,
      ),
    ];

    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        physics: const BouncingScrollPhysics(),
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) => _QuickActionCard(data: actions[i]),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SERVICES
  // ─────────────────────────────────────────────
  Widget _buildServices() {
    final services = [
      _ServiceData(icon: Icons.phone_android_rounded,         label: 'Recharge',  active: false),
      _ServiceData(icon: Icons.volunteer_activism_rounded,    label: 'Charity',   active: false),
      _ServiceData(icon: Icons.account_balance_wallet_rounded,label: 'Loan',      active: false),
      _ServiceData(icon: Icons.card_giftcard_rounded,         label: 'Gifts',     active: true),
      _ServiceData(icon: Icons.security_rounded,              label: 'Insur.',    active: false),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        physics: const BouncingScrollPhysics(),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _ServiceIconWidget(data: services[i]),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SCHEDULE PAYMENTS HEADER
  // ─────────────────────────────────────────────
  Widget _buildScheduleHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Schedule Payments', style: kStyleSubheading),
          Text(
            'View All',
            style: kStyleCaption.copyWith(
              color: kTextGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // PAYMENTS LIST
  // ─────────────────────────────────────────────
  Widget _buildPaymentsList() {
    final payments = [
      _PaymentData(
        name: 'Netflix',
        date: '12/04',
        amount: 1.00,
        bgColor: Colors.black,
        icon: Icons.play_arrow_rounded,
        iconColor: const Color(0xFFE50914),
      ),
      _PaymentData(
        name: 'Paypal',
        date: '14/04',
        amount: 3.50,
        bgColor: const Color(0xFF003087),
        icon: Icons.payment_rounded,
        iconColor: const Color(0xFF009CDE),
      ),
      _PaymentData(
        name: 'Spotify',
        date: '13/04',
        amount: 10.00,
        bgColor: const Color(0xFF1DB954),
        icon: Icons.music_note_rounded,
        iconColor: Colors.white,
      ),
    ];

    return Column(
      children: payments
          .map((p) => _PaymentTile(data: p))
          .toList(),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
      child: Text(title, style: kStyleSubheading),
    );
  }
}

// ─────────────────────────────────────────────
// DATA MODELS (local)
// ─────────────────────────────────────────────
class _ActionData {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color bgColor;
  const _ActionData({required this.icon, required this.label, required this.iconColor, required this.bgColor});
}

class _ServiceData {
  final IconData icon;
  final String label;
  final bool active;
  const _ServiceData({required this.icon, required this.label, required this.active});
}

class _PaymentData {
  final String name;
  final String date;
  final double amount;
  final Color bgColor;
  final IconData icon;
  final Color iconColor;
  const _PaymentData({required this.name, required this.date, required this.amount, required this.bgColor, required this.icon, required this.iconColor});
}

// ─────────────────────────────────────────────
// QUICK ACTION CARD
// ─────────────────────────────────────────────
class _QuickActionCard extends StatelessWidget {
  final _ActionData data;
  const _QuickActionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: kBackground,
        borderRadius: BorderRadius.circular(kItemRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: data.bgColor,
              borderRadius: BorderRadius.circular(kSmallRadius),
            ),
            child: Icon(data.icon, color: data.iconColor, size: 24),
          ),
          const SizedBox(height: 9),
          Text(
            data.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: kTextDark,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SERVICE ICON
// ─────────────────────────────────────────────
class _ServiceIconWidget extends StatelessWidget {
  final _ServiceData data;
  const _ServiceIconWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: data.active ? kPrimary : kBackground,
            borderRadius: BorderRadius.circular(kItemRadius),
            boxShadow: data.active
                ? [
                    BoxShadow(
                      color: kPrimary.withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Icon(
            data.icon,
            color: data.active ? Colors.white : const Color(0xFF6C63FF),
            size: 26,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          data.label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: data.active ? kPrimary : kTextGrey,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// PAYMENT TILE
// ─────────────────────────────────────────────
class _PaymentTile extends StatelessWidget {
  final _PaymentData data;
  const _PaymentTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingH, vertical: 9),
      child: Row(
        children: [
          // App icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: data.bgColor,
              borderRadius: BorderRadius.circular(kSmallRadius),
              boxShadow: [
                BoxShadow(
                  color: data.bgColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(data.icon, color: data.iconColor, size: 26),
          ),
          const SizedBox(width: 14),
          // Name + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kTextDark,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: 'Next Payment: ',
                    style: kStyleCaption,
                    children: [
                      TextSpan(
                        text: data.date,
                        style: const TextStyle(
                          color: kPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Amount
          RichText(
            text: TextSpan(
              text: '\$${data.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: kTextDark,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
              children: const [
                TextSpan(
                  text: 'usd',
                  style: TextStyle(
                    color: kTextGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
