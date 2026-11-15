import 'package:material_ui/material_ui.dart';
import 'package:flutter_design_system/flutter_design_system.dart' as ds;

class DataPreviewCardPage extends StatelessWidget {
  const DataPreviewCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ds.AppScaffold(
      title: 'Data Preview Card',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(context, 'Basic Data Preview Card', children: [
            ds.DataPreviewCard(
              titleText: 'Total Revenue',
              isShowWidgetTitle: false,
              value: '\$124,500',
              valueLabel: 'Current',
              lottieTitleText: 'Growth',
              lottieWidget: _buildMockLottie(Icons.trending_up),
            ),
          ]),
          _section(context, 'Card with Status', children: [
            ds.DataPreviewCard(
              titleText: 'Server Status',
              isShowWidgetTitle: false,
              value: 'Operational',
              valueLabel: 'Status',
              status: 'Online',
              statusColor: Colors.green,
              lottieTitleText: 'Health',
              lottieWidget: _buildMockLottie(Icons.check_circle),
            ),
          ]),
          _section(context, 'Card with Description', children: [
            ds.DataPreviewCard(
              titleText: 'Storage Usage',
              isShowWidgetTitle: false,
              value: '78%',
              valueLabel: 'Used',
              status: 'Warning',
              statusColor: Colors.orange,
              description:
                  'Your storage is almost full. Consider upgrading your plan.',
              lottieTitleText: 'Space',
              lottieWidget: _buildMockLottie(Icons.storage),
            ),
          ]),
          _section(context, 'Card with Custom Title Widget', children: [
            ds.DataPreviewCard(
              titleText: 'Custom Title Widget',
              isShowWidgetTitle: false,
              value: 'Active',
              valueLabel: 'Status',
              titleWidget: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Server Status',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              lottieTitleText: 'Health',
              lottieWidget: _buildMockLottie(Icons.health_and_safety),
            ),
          ]),
          _section(context, 'Card with Custom Description Widget', children: [
            ds.DataPreviewCard(
              titleText: 'Storage Usage',
              isShowWidgetTitle: false,
              value: '78%',
              valueLabel: 'Used',
              status: 'Warning',
              statusColor: Colors.orange,
              descriptionWidget: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Your storage is almost full',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              lottieTitleText: 'Space',
              lottieWidget: _buildMockLottie(Icons.storage),
            ),
          ]),
          _section(context, 'Card Without Title', children: [
            ds.DataPreviewCard(
              titleText: 'Hidden Title',
              isShowWidgetTitle: false,
              value: '95°F',
              valueLabel: 'Temperature',
              showTitle: false,
              lottieTitleText: 'Hot',
              lottieWidget: _buildMockLottie(Icons.thermostat),
            ),
          ]),
          _section(context, 'Card with Custom Value Widget', children: [
            ds.DataPreviewCard(
              titleText: 'Network Speed',
              isShowWidgetTitle: false,
              value: '1.2 Gbps',
              valueLabel: 'Current',
              valueWidget: Row(
                children: [
                  const Icon(Icons.speed, color: Colors.blue, size: 24),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1.2 Gbps',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Upload Speed',
                        style: TextStyle(
                          color: Colors.blue.withValues(alpha: 0.7),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              lottieTitleText: 'Speed',
              lottieWidget: _buildMockLottie(Icons.network_check),
            ),
          ]),
          _section(context, 'Card Without Value', children: [
            ds.DataPreviewCard(
              titleText: 'Status Only',
              isShowWidgetTitle: false,
              value: 'N/A',
              valueLabel: 'Status',
              showValue: false,
              status: 'Processing',
              statusColor: Colors.orange,
              lottieTitleText: 'Working',
              lottieWidget: _buildMockLottie(Icons.refresh),
            ),
          ]),
          _section(context, 'Card Without Description', children: [
            ds.DataPreviewCard(
              titleText: 'Temperature',
              isShowWidgetTitle: false,
              value: '72°F',
              valueLabel: 'Current',
              showDescription: false,
              lottieTitleText: 'Comfort',
              lottieWidget: _buildMockLottie(Icons.thermostat),
            ),
          ]),
          _section(context, 'Card with Status and Description', children: [
            ds.DataPreviewCard(
              titleText: 'API Requests',
              isShowWidgetTitle: false,
              value: '98.5%',
              valueLabel: 'Success Rate',
              status: 'Excellent',
              statusColor: Colors.green,
              description:
                  'All systems are performing optimally with high availability.',
              lottieTitleText: 'Performance',
              lottieWidget: _buildMockLottie(Icons.speed),
            ),
          ]),
          _section(context, 'Card with Custom Styling', children: [
            ds.DataPreviewCard(
              titleText: 'Active Users',
              isShowWidgetTitle: false,
              value: '8,432',
              valueLabel: 'Today',
              lottieTitleText: 'Online',
              lottieWidget: _buildMockLottie(Icons.people),
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              valueStyle: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.blue,
              ),
            ),
          ]),
          _section(context, 'Multiple Cards Grid', children: [
            GridView.count(
              crossAxisCount: context.isWindowCompact ? 1 : 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                ds.DataPreviewCard(
                  titleText: 'Orders',
                  isShowWidgetTitle: false,
                  value: '1,234',
                  valueLabel: 'Total',
                  lottieTitleText: 'Today',
                  lottieWidget: _buildMockLottie(Icons.shopping_cart),
                ),
                ds.DataPreviewCard(
                  titleText: 'Conversion',
                  isShowWidgetTitle: false,
                  value: '3.2%',
                  valueLabel: 'Rate',
                  lottieTitleText: 'Trend',
                  lottieWidget: _buildMockLottie(Icons.show_chart),
                ),
                ds.DataPreviewCard(
                  titleText: 'Bounce Rate',
                  isShowWidgetTitle: false,
                  value: '42%',
                  valueLabel: 'Current',
                  lottieTitleText: 'Status',
                  lottieWidget: _buildMockLottie(Icons.analytics),
                ),
                ds.DataPreviewCard(
                  titleText: 'Session Time',
                  isShowWidgetTitle: false,
                  value: '4m 32s',
                  valueLabel: 'Average',
                  lottieTitleText: 'Duration',
                  lottieWidget: _buildMockLottie(Icons.access_time),
                ),
              ],
            ),
          ]),
          _section(context, 'Compact Variant', children: [
            const ds.DataPreviewCardCompact(
              title: 'Downloads',
              value: '45,678',
              icon: Icon(Icons.download, color: Colors.green),
            ),
            const SizedBox(height: 8),
            const ds.DataPreviewCardCompact(
              title: 'Uploads',
              value: '12,345',
              icon: Icon(Icons.upload, color: Colors.orange),
            ),
            const SizedBox(height: 8),
            const ds.DataPreviewCardCompact(
              title: 'Storage Used',
              value: '78%',
              icon: Icon(Icons.storage, color: Colors.purple),
            ),
          ]),
          _section(context, 'Compact Variant with Status', children: [
            const ds.DataPreviewCardCompact(
              title: 'CPU Usage',
              value: '45%',
              status: 'Normal',
              statusColor: Colors.green,
              icon: Icon(Icons.memory, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const ds.DataPreviewCardCompact(
              title: 'Memory',
              value: '82%',
              status: 'High',
              statusColor: Colors.orange,
              icon: Icon(Icons.storage, color: Colors.orange),
            ),
            const SizedBox(height: 8),
            const ds.DataPreviewCardCompact(
              title: 'Disk',
              value: '95%',
              status: 'Critical',
              statusColor: Colors.red,
              icon: Icon(Icons.sd_card, color: Colors.red),
            ),
          ]),
          _section(context, 'Compact Variant with Custom Value', children: [
            const ds.DataPreviewCardCompact(
              title: 'Download',
              value: '45.6 MB/s',
              icon: Icon(Icons.download, color: Colors.green),
              valueWidget: Row(
                children: [
                  Icon(Icons.arrow_downward, color: Colors.green, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '45.6 MB/s',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ]),
          _section(context, 'Compact Variant Without Title', children: [
            const ds.DataPreviewCardCompact(
              title: 'Hidden',
              value: 'Active',
              icon: Icon(Icons.check_circle, color: Colors.green),
              showTitle: false,
            ),
            const SizedBox(height: 8),
            const ds.DataPreviewCardCompact(
              title: 'Hidden',
              value: 'Warning',
              icon: Icon(Icons.warning, color: Colors.orange),
              showTitle: false,
            ),
          ]),
          _section(context, 'Card Without Lottie', children: [
            ds.DataPreviewCard(
              titleText: 'Server Status',
              isShowWidgetTitle: false,
              value: 'Operational',
              valueLabel: 'Status',
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              valueStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ]),
          _section(context, 'With Custom Border Radius', children: [
            const ds.DataPreviewCard(
              titleText: 'Temperature',
              isShowWidgetTitle: false,
              value: '24°C',
              valueLabel: 'Room',
              lottieTitleText: 'Climate',
              lottieWidget: ds.ThermometerWidget(
                celsius: 24,
                width: 80,
                height: 110,
                showFahrenheit: false,
                showMinorLabels: true,
                showSunIcon: false,
                showCelsius: false,
                showHumidity: false,
                readoutStyle: ds.ThermometerReadoutStyle.simpleBadge,
                interactive: false,
              ),
              borderRadius: 24,
              padding: EdgeInsets.all(20),
              status: 'Normal',
              description: 'Temperature monitoring system',
            ),
          ]),
          _section(context, 'Card with Leading Widget', children: [
            ds.DataPreviewCard(
              titleText: 'Network Speed',
              isShowWidgetTitle: false,
              value: '1.2 Gbps',
              valueLabel: 'Current',
              status: 'Connected',
              leadingWidget: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.network_check,
                  color: Colors.blue,
                  size: 28,
                ),
              ),
              lottieTitleText: 'Speed',
              lottieWidget: _buildMockLottie(Icons.speed),
            ),
          ]),
          _section(context, 'Financial Data Example', children: [
            ds.DataPreviewCard(
              titleText: 'Portfolio Value',
              isShowWidgetTitle: false,
              value: '\$1.2M',
              valueLabel: 'Total',
              lottieTitleText: '+12.5%',
              lottieWidget: _buildMockLottie(Icons.account_balance),
              backgroundColor: Colors.green.withValues(alpha: 0.08),
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              valueStyle: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              lottieTitleStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildMockLottie(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 32,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _section(BuildContext context, String title,
      {required List<Widget> children}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
