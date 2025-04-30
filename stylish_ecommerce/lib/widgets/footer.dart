import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      color: Colors.black,
      child: Column(
        children: [
          if (isDesktop)
            // Desktop layout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBrandSection(),
                const SizedBox(width: 20),
                _buildLinksSection(),
                const SizedBox(width: 20),
                _buildSocialSection(),
              ],
            )
          else
            // Mobile layout
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBrandSection(),
                const SizedBox(height: 30),
                _buildLinksSection(),
                const SizedBox(height: 30),
                _buildSocialSection(),
              ],
            ),
          const SizedBox(height: 40),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} ARTISANAL. All rights reserved.',
            style: AppTheme.bodyStyle.copyWith(
              color: Colors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'POTTERY OF KUTCH',
          style: AppTheme.subheadingStyle,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 300,
          child: Text(
            'Handcrafted pottery from Gujarat, where art, earth, and heritage come together. Each piece carries the soul of the desert and the touch of a skilled artisan.',
            style: AppTheme.bodyStyle.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Links',
          style: AppTheme.productNameStyle,
        ),
        const SizedBox(height: 16),
        _buildFooterLink('About Us'),
        _buildFooterLink('Contact'),
        _buildFooterLink('Terms & Conditions'),
        _buildFooterLink('Privacy Policy'),
        _buildFooterLink('FAQs'),
      ],
    );
  }

  Widget _buildSocialSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Us',
          style: AppTheme.productNameStyle,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialIcon(Icons.facebook_outlined, 'https://facebook.com'),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.photo_camera_outlined, 'https://instagram.com'),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.push_pin_outlined, 'https://pinterest.com'),
            const SizedBox(width: 16),
            _buildSocialIcon(Icons.video_library_outlined, 'https://youtube.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          text,
          style: AppTheme.bodyStyle.copyWith(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Icon(
          icon,
          color: AppTheme.accentColor,
          size: 20,
        ),
      ),
    );
  }
}
