import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/steps_viewmodel.dart';
import '../widgets/watch_steps_card.dart';
import '../widgets/loading_widget.dart';

class WatchStepsScreen extends StatefulWidget {
  const WatchStepsScreen({super.key});

  @override
  State<WatchStepsScreen> createState() => _WatchStepsScreenState();
}

class _WatchStepsScreenState extends State<WatchStepsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepsViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<StepsViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.state) {
            case StepsState.initial:
            case StepsState.loading:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 2,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Carregando...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
              
            case StepsState.loaded:
              return GestureDetector(
                onTap: () => viewModel.refresh(),
                child: Center(
                  child: WatchStepsCard(
                    steps: viewModel.steps,
                    source: viewModel.source,
                    date: viewModel.formattedDate,
                    time: viewModel.formattedTime,
                  ),
                ),
              );
              
            case StepsState.noPermissions:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        color: Colors.blue[400],
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Permissão Necessária',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Toque para conceder',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: viewModel.requestPermissions,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'CONCEDER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              
            case StepsState.error:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[400],
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Erro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.errorMessage,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: viewModel.initialize,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'TENTAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
} 