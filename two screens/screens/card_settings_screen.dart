import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/shared_widgets.dart';

class CardSettingsScreen extends StatefulWidget {
  const CardSettingsScreen({super.key});

  @override
  State<CardSettingsScreen> createState() => _CardSettingsScreenState();
}

class _CardSettingsScreenState extends State<CardSettingsScreen> {
  bool _lockCard = false;
  bool _deactivateCard = true;

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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: kPaddingH),
                      child: CreditCardWidget(),
                    ),
                    const SizedBox(height: 10),
                    const CardDotsIndicator(count: 3, active: 1),
                    const SizedBox(height: 24),

                    // ── Credit Limit + Card Status ────────────
                    _buildInfoCards(),
                    const SizedBox(height: 28),

                    // ── Settings Section ─────────────────────
                    _buildSettingsSection(),
                    const SizedBox(height: 32),

                    // ── Save Button ──────────────────────────
                    _buildSaveButton(context),
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
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: kBackground,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: kTextDark,
                size: 18,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('My Card', style: kStyleHeading),
            ),
          ),
          const NotificationBell(),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // INFO CARDS (Credit Limit + Card Status)
  // ─────────────────────────────────────────────
  Widget _buildInfoCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
      child: Row(
        children: [
          // Credit Limit
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: kGreenLight,
                borderRadius: BorderRadius.circular(kItemRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Credit Limit',
                    style: TextStyle(
                      color: kGreenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: const TextSpan(
                      text: '\$271.00',
                      style: TextStyle(
                        color: kGreenAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                      children: [
                        TextSpan(
                          text: ' usd',
                          style: TextStyle(
                            color: kGreenAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Card Status
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: kRedLight,
                borderRadius: BorderRadius.circular(kItemRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Card Status',
                    style: TextStyle(
                      color: kRedAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Active',
                    style: TextStyle(
                      color: kRedAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SETTINGS SECTION
  // ─────────────────────────────────────────────
  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Settings', style: kStyleSubheading),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(kItemRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Change Pin
                _SettingsRow(
                  icon: Icons.shield_outlined,
                  iconBg: kGreenLight,
                  iconColor: kGreenAccent,
                  label: 'Change Pin',
                  trailing: const _ChevronButton(),
                  onTap: () {},
                ),
                _Divider(),
                // Lock Card
                _SettingsRow(
                  icon: Icons.lock_outline_rounded,
                  iconBg: kRedLight,
                  iconColor: kRedAccent,
                  label: 'Lock Card',
                  trailing: _StyledSwitch(
                    value: _lockCard,
                    onChanged: (v) => setState(() => _lockCard = v),
                    activeColor: kPrimary,
                  ),
                  onTap: null,
                ),
                _Divider(),
                // Deactivate Card
                _SettingsRow(
                  icon: Icons.credit_card_off_outlined,
                  iconBg: const Color(0xFFEEEDFF),
                  iconColor: const Color(0xFF6C63FF),
                  label: 'Deactivate Card',
                  trailing: _StyledSwitch(
                    value: _deactivateCard,
                    onChanged: (v) => setState(() => _deactivateCard = v),
                    activeColor: kPrimary,
                  ),
                  onTap: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SAVE BUTTON
  // ─────────────────────────────────────────────
  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Card settings saved!'),
              backgroundColor: kPrimary,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4B6CF7), kPrimaryDark],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(kItemRadius),
            boxShadow: [
              BoxShadow(
                color: kPrimary.withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SETTINGS ROW
// ─────────────────────────────────────────────
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            // Label
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kTextDark,
                ),
              ),
            ),
            // Trailing widget
            trailing,
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CHEVRON BUTTON
// ─────────────────────────────────────────────
class _ChevronButton extends StatelessWidget {
  const _ChevronButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: kBackground,
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Icon(Icons.chevron_right_rounded, color: kTextGrey, size: 20),
    );
  }
}

// ─────────────────────────────────────────────
// STYLED SWITCH
// ─────────────────────────────────────────────
class _StyledSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const _StyledSwitch({
    required this.value,
    required this.onChanged,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
        activeTrackColor: activeColor,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFFDDDEEA),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DIVIDER
// ─────────────────────────────────────────────
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, thickness: 1, color: kDivider),
    );
  }
}
