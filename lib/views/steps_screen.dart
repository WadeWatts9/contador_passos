import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/steps_viewmodel.dart';
import '../widgets/steps_card.dart';
import '../widgets/permission_request_widget.dart';
import '../widgets/error_widget.dart' as custom_error;
import '../widgets/loading_widget.dart';
import '../widgets/responsive_layout.dart';
import 'watch_steps_screen.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the ViewModel when the screen is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepsViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileLayout(),
      watch: const WatchStepsScreen(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contador de Passos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        actions: [
          Consumer<StepsViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.state == StepsState.loaded) {
                return IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: () => viewModel.refresh(),
                  tooltip: 'Atualizar',
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<StepsViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.state) {
            case StepsState.initial:
            case StepsState.loading:
              return const LoadingWidget();
              
            case StepsState.loaded:
              return RefreshIndicator(
                onRefresh: viewModel.refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      StepsCard(
                        steps: viewModel.steps,
                        source: viewModel.source,
                        date: viewModel.formattedDate,
                        time: viewModel.formattedTime,
                      ),
                      const SizedBox(height: 20),
                      _buildInfoCard(),
                      const SizedBox(height: 20),
                      _buildSettingsCard(viewModel),
                    ],
                  ),
                ),
              );
              
            case StepsState.noPermissions:
              return PermissionRequestWidget(
                onRequestPermissions: viewModel.requestPermissions,
                errorMessage: viewModel.errorMessage,
              );
              
            case StepsState.error:
              return custom_error.CustomErrorWidget(
                message: viewModel.errorMessage,
                onRetry: viewModel.initialize,
              );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[600]),
                const SizedBox(width: 8),
                Text(
                  'Informações',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '• Este app coleta dados de passos do seu smartwatch via Health Connect',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Os dados são das últimas 24 horas',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Puxe para baixo para atualizar os dados',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(StepsViewModel viewModel) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings, color: Colors.blue[600]),
                const SizedBox(width: 8),
                Text(
                  'Configurações',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Gerenciar Permissões'),
              subtitle: const Text('Revogar acesso aos dados'),
              onTap: () => _showRevokePermissionsDialog(viewModel),
            ),
          ],
        ),
      ),
    );
  }

  void _showRevokePermissionsDialog(StepsViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revogar Permissões'),
        content: const Text(
          'Tem certeza que deseja revogar as permissões do Health Connect? '
          'Você precisará conceder novamente para usar o app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              viewModel.revokePermissions();
            },
            child: const Text('Revogar'),
          ),
        ],
      ),
    );
  }
} 