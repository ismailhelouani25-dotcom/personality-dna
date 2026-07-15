import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بصمة شخصيتك'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أهلاً بك! 👋',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'اكتشف شخصيتك الحقيقية من خلال اختباراتنا العلمية',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Quick Test Card
              Card(
                child: ListTile(
                  leading: Icon(Icons.lightning_bolt, color: Color(0xFFF59E0B)),
                  title: Text('اختبار الشخصية السريع'),
                  subtitle: Text('10 أسئلة - دقيقة واحدة'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/test/quick');
                  },
                ),
              ),
              SizedBox(height: 12),
              
              // Full Test Card
              Card(
                child: ListTile(
                  leading: Icon(Icons.assessment, color: Color(0xFF3B82F6)),
                  title: Text('الاختبار الكامل'),
                  subtitle: Text('50-100 سؤال - تحليل متعمق'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, '/test/full');
                  },
                ),
              ),
              SizedBox(height: 24),
              
              // Specialized Tests
              Text(
                'اختبارات متخصصة',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildSpecializedCard(context, 'تحليل القيادة', Icons.people, Color(0xFFEC4899)),
                  _buildSpecializedCard(context, 'الذكاء العاطفي', Icons.favorite, Color(0xFFEF4444)),
                  _buildSpecializedCard(context, 'الثقة بالنفس', Icons.star, Color(0xFFF59E0B)),
                  _buildSpecializedCard(context, 'التواصل', Icons.chat, Color(0xFF10B981)),
                  _buildSpecializedCard(context, 'إدارة التوتر', Icons.psychology, Color(0xFF6366F1)),
                  _buildSpecializedCard(context, 'الإبداع', Icons.lightbulb, Color(0xFF8B5CF6)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecializedCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/test/specialized', arguments: title);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
