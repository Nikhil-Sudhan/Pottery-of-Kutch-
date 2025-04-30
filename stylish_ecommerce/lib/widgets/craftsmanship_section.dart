import 'package:flutter/material.dart';
import '../utils/theme.dart';

class CraftsmanshipSection extends StatelessWidget {
  const CraftsmanshipSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: AppTheme.secondaryColor,
      child: Column(
        children: [
          if (isDesktop)
            // Desktop layout (horizontal)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildContent()),
                const SizedBox(width: 40),
                _buildIcon(),
              ],
            )
          else
            // Mobile layout (vertical)
            Column(
              children: [
                _buildIcon(),
                const SizedBox(height: 24),
                _buildContent(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Our Pottery',
          style: AppTheme.subheadingStyle,
        ),
        const SizedBox(height: 20),
        Text(
          'Rooted in centuries-old tradition, our pottery is handcrafted in the vibrant region of Kutch, Gujarat—where art, earth, and heritage come together. Each piece is molded from locally sourced clay and shaped using ancient techniques passed down through generations of Kumbhar artisans.',
          style: AppTheme.bodyStyle,
        ),
        const SizedBox(height: 20),
        Text(
          'Kutch pottery is known for its earthy tones, hand-painted motifs, and delicate balance of function and beauty. At the heart of our work lies sustainability, slow craft, and a deep respect for cultural legacy—bringing timeless artistry into your everyday living spaces.',
          style: AppTheme.bodyStyle,
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.accentColor, width: 2),
      ),
      child: Icon(
        Icons.handyman_outlined,
        size: 50,
        color: AppTheme.accentColor,
      ),
    );
  }
}
