import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/footer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      drawer: isDesktop ? null : _buildMobileDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomNavigationBar(currentRoute: '/about'),
            _buildPageHeader(),
            _buildHistorySection(isDesktop),
            _buildArtisanStories(isDesktop),
            _buildProcess(isDesktop),
            _buildMotifs(isDesktop),
            _buildSustainability(isDesktop),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppTheme.primaryColor,
      child: Column(
        children: [
          Text(
            'Our Story',
            style: GoogleFonts.playfairDisplay(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 2,
            color: AppTheme.accentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isDesktop ? 120 : 24,
      ),
      color: AppTheme.secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'History & Heritage',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'The art of pottery in Kutch dates back over 5,000 years, tracing its roots to the Indus Valley Civilization. Archaeological discoveries from sites like Dholavira reveal that clay pottery was not only a functional craft but also a deeply symbolic and artistic tradition in this region.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'In Kutch, pottery has traditionally been the domain of the Kumbhar community, whose name literally means "potter." These artisans use locally sourced clay, and many still follow traditional methods—using simple hand tools, foot-powered wheels, and open firing techniques.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The designs often feature geometric patterns, hand-painting in earthy tones, and motifs inspired by nature and local folklore. In villages like Lodai, Khavda, and Bhujodi, you\'ll still find families working together to shape pots, toys, diyas, and decorative pieces—each carrying a story from the desert landscape.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Though modernity has challenged the continuity of the craft, many Kutch potters have adapted, blending tradition with contemporary design while preserving their cultural heritage. Today, Kutch pottery is celebrated not only in Indian homes but also in global artisan markets.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtisanStories(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isDesktop ? 120 : 24,
      ),
      color: AppTheme.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Artisan Stories',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Behind every piece of our pottery is a skilled artisan whose hands carry generations of tradition. Our work is rooted in the Kumbhar communities of villages like Khavda, Lodai, and Nirona—where families have been practicing the art of pottery for centuries.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'These artisans do more than shape clay; they carry forward oral histories, ancient techniques, and cultural pride. Each pot, diya, or decorative piece reflects the artisan\'s individual touch—subtle variations in form, texture, and painting that make every object unique.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'By supporting their craft, we are not just preserving a dying tradition—we\'re enabling rural livelihoods, empowering women and youth, and keeping cultural identity alive through everyday objects.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcess(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isDesktop ? 120 : 24,
      ),
      color: AppTheme.secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Process',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Our pottery is made through a slow, mindful process that honors the natural rhythm of the earth and the heritage of the maker. It begins with locally sourced clay from the arid land of Kutch—rich in minerals and ideal for handcrafting.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Artisans knead the clay and shape it using traditional hand tools and the potter\'s wheel, powered by foot. Once shaped, the pieces are dried naturally under the sun, then decorated by hand using natural paints and patterns passed down through generations.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The final step is open firing—a traditional method using cow dung and brushwood to harden and cure the pottery. Each item is the result of days of work, countless skilled movements, and an intuitive relationship with the material.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotifs(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isDesktop ? 120 : 24,
      ),
      color: AppTheme.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meaning of Motifs',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'The surface of Kutch pottery is more than decorative—it tells stories. Motifs are inspired by the desert landscape, daily life, and ancient symbols that hold cultural meaning.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Geometric patterns, dots, and lines reflect harmony and balance. Fish symbolize fertility and abundance. Sun motifs represent warmth, energy, and the eternal cycle of life. Birds like peacocks and parrots are often used to evoke celebration and freedom.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'These patterns are hand-painted using natural hues—mostly white and black over the natural red of the clay. Every brushstroke connects the past to the present, tradition to modern design.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSustainability(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isDesktop ? 120 : 24,
      ),
      color: AppTheme.secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Materials & Sustainability',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'We believe in creating beauty that\'s rooted in responsibility. All our pottery is crafted from locally sourced natural clay, with no chemical additives. The colors used are natural mineral-based pigments, and firing is done using traditional eco-conscious methods that require minimal energy.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Because our pieces are handmade, they generate no industrial waste, and many are biodegradable or recyclable at the end of their life cycle.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Our packaging is plastic-free and thoughtfully designed to protect fragile items without harming the environment. By choosing our pottery, you\'re not just supporting artisans—you\'re also choosing sustainability, tradition, and mindful living.',
            style: GoogleFonts.lora(
              fontSize: 16,
              height: 1.8,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF212121),
            ),
            child: Text(
              'POTTERY OF KUTCH',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(context, 'Home', Icons.home),
          _buildDrawerItem(context, 'About', Icons.info_outline, isActive: true),
          _buildDrawerItem(context, 'Products', Icons.shopping_bag),
          _buildDrawerItem(context, 'Cart', Icons.shopping_cart),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, {bool isActive = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppTheme.accentColor : const Color(0xFFD4AF37),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (title == 'Home') {
          Navigator.pushReplacementNamed(context, '/');
        } else if (title == 'Products') {
          Navigator.pushReplacementNamed(context, '/products');
        } else if (title == 'Cart') {
          Navigator.pushReplacementNamed(context, '/cart');
        } else if (title == 'About' && !isActive) {
          Navigator.pushReplacementNamed(context, '/about');
        }
      },
    );
  }
}
