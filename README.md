# Contador de Passos - Aplicativo Flutter

Um aplicativo Android desenvolvido em Flutter que utiliza a API Health Connect para coletar dados de passos de smartwatches com Wear OS, seguindo o padrão arquitetural MVVM.

## 📱 Funcionalidades

- **Coleta de dados de passos**: Acessa dados sincronizados do smartwatch via Health Connect
- **Interface responsiva**: Design adaptativo para smartphones e smartwatches
- **Versão para Wear OS**: Interface otimizada para smartwatches quadrados
- **Interface moderna**: Design limpo e intuitivo com Material Design 3
- **Atualização em tempo real**: Pull-to-refresh para atualizar dados
- **Gerenciamento de permissões**: Interface para conceder e revogar permissões
- **Tratamento de erros**: Feedback claro para o usuário em caso de problemas

## 🏗️ Arquitetura MVVM

O projeto segue o padrão Model-View-ViewModel (MVVM):

### 📁 Estrutura do Projeto

```
lib/
├── models/
│   └── step_data.dart          # Modelo de dados para passos
├── services/
│   └── health_connect_service.dart  # Serviço para Health Connect
├── viewmodels/
│   └── steps_viewmodel.dart    # ViewModel principal
├── views/
│   ├── steps_screen.dart       # Tela principal responsiva
│   └── watch_steps_screen.dart # Tela específica para smartwatch
├── widgets/
│   ├── steps_card.dart         # Card de exibição de passos (mobile)
│   ├── watch_steps_card.dart   # Card de exibição de passos (watch)
│   ├── responsive_layout.dart  # Layout responsivo
│   ├── permission_request_widget.dart  # Widget de permissões
│   ├── error_widget.dart       # Widget de erro
│   └── loading_widget.dart     # Widget de carregamento
└── main.dart                   # Ponto de entrada da aplicação
```

### 🔧 Componentes MVVM

- **Model**: `StepData` - Representa os dados de passos
- **View**: `StepsScreen` e widgets - Interface do usuário
- **ViewModel**: `StepsViewModel` - Lógica de negócio e estado
- **Service**: `HealthConnectService` - Acesso a dados externos

## 🚀 Como Executar

### Pré-requisitos

1. **Flutter SDK**: Versão 3.5.4 ou superior
2. **Android Studio** ou **VS Code** com extensões Flutter
3. **Dispositivo Android** com API 26+ (Android 8.0+)
4. **Health Connect** instalado no dispositivo
5. **Smartwatch Wear OS** conectado (opcional para testes)

### 📱 Versão para Smartwatch

O aplicativo detecta automaticamente o tipo de dispositivo e adapta a interface:

- **Smartphones**: Interface completa com cards, informações e configurações
- **Smartwatches**: Interface compacta otimizada para telas pequenas e quadradas

#### Características da versão para smartwatch:
- 🎯 **Interface minimalista** com foco nos dados essenciais
- 📱 **Tela quadrada** otimizada para Wear OS
- 🔄 **Toque para atualizar** os dados
- 🌙 **Tema escuro** por padrão
- ⚡ **Carregamento rápido** e responsivo

### Instalação

1. **Clone o repositório**:
   ```bash
   git clone [URL_DO_REPOSITORIO]
   cd contador_pasos
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**:
   ```bash
   flutter run
   ```

### Configuração do Health Connect

1. **Instale o Health Connect** na Google Play Store
2. **Configure as permissões** no app Health Connect
3. **Conecte seu smartwatch** (se aplicável)
4. **Execute o aplicativo** e conceda as permissões solicitadas

## 🔐 Permissões Utilizadas

O aplicativo solicita as seguintes permissões:

- `android.permission.health.READ_STEPS`: Leitura de dados de passos
- `android.permission.health.WRITE_STEPS`: Escrita de dados de passos (para compatibilidade)
- `android.permission.INTERNET`: Conexão com internet
- `android.permission.ACCESS_NETWORK_STATE`: Verificação de estado da rede

## 📊 Como os Dados são Acessados

### Health Connect API

O aplicativo utiliza a API Health Connect para:

1. **Verificar disponibilidade**: Confirma se o Health Connect está instalado
2. **Solicitar permissões**: Pede acesso aos dados de passos
3. **Ler dados**: Coleta passos das últimas 24 horas
4. **Processar informações**: Calcula total e identifica fonte dos dados

### Fluxo de Dados

```
Smartwatch → Health Connect → Aplicativo → Interface do Usuário
```

1. O smartwatch registra passos
2. Health Connect sincroniza os dados
3. O aplicativo solicita acesso via API
4. Dados são processados e exibidos

## 🧪 Simulação de Passos no Relógio

Para testar o aplicativo sem um smartwatch físico, use os comandos ADB:

### Pré-requisitos para Simulação

1. **Emulador Wear OS** configurado
2. **ADB** conectado ao emulador
3. **Health Connect** instalado no emulador

### Comandos de Simulação

```bash
# Listar dispositivos conectados
adb devices

# Ativar provedores sintéticos (substitua [NOME_DO_EMULADOR])
adb -s [NOME_DO_EMULADOR] shell am broadcast -a "whs.USE_SYNTHETIC_PROVIDERS" com.google.android.wearable.healthservices

# Iniciar simulação de caminhada
adb -s [NOME_DO_EMULADOR] shell am broadcast -a "whs.synthetic.user.START_WALKING" com.google.android.wearable.healthservices

# Parar simulação de exercício
adb -s [NOME_DO_EMULADOR] shell am broadcast -a "whs.synthetic.user.STOP_EXERCISE" com.google.android.wearable.healthservices
```

### Exemplo de Uso

#### **Método 1: Comandos manuais**
```bash
# Conectar ao emulador
adb connect 127.0.0.1:5555

# Ativar simulação
adb -s emulator-5554 shell am broadcast -a "whs.USE_SYNTHETIC_PROVIDERS" com.google.android.wearable.healthservices

# Simular caminhada
adb -s emulator-5554 shell am broadcast -a "whs.synthetic.user.START_WALKING" com.google.android.wearable.healthservices

# Aguardar alguns segundos e parar
adb -s emulator-5554 shell am broadcast -a "whs.synthetic.user.STOP_EXERCISE" com.google.android.wearable.healthservices
```

#### **Método 2: Scripts automatizados**

**Windows:**
```bash
# Execute o arquivo batch
simulate_steps.bat
```

**Linux/Mac:**
```bash
# Torne o script executável
chmod +x simulate_steps.sh

# Execute o script
./simulate_steps.sh
```

### **Passo a passo completo:**

1. **Configurar emulador Wear OS:**
   - Abra Android Studio
   - Tools > AVD Manager
   - Create Virtual Device > Wear > Square
   - Escolha API 30+ e finalize

2. **Iniciar o emulador:**
   - Clique em "Play" no AVD Manager
   - Aguarde o emulador carregar

3. **Executar simulação:**
   - Use um dos métodos acima
   - Aguarde 10-15 segundos para gerar dados

4. **Testar o aplicativo:**
   - Execute `flutter run` no smartphone
   - Conceda permissões
   - Veja os dados sincronizados

## 📱 Screenshots

[Inserir screenshots do aplicativo em funcionamento]

## 🎥 Vídeo Demonstrativo

[Inserir link para vídeo demonstrativo]

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento
- **Provider**: Gerenciamento de estado
- **Health Connect**: API para dados de saúde
- **Material Design 3**: Design system
- **Dart**: Linguagem de programação

## 📋 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  health_connect: ^1.0.0
  provider: ^6.1.1
  intl: ^0.19.0
  permission_handler: ^11.3.0
```

## 🔍 Troubleshooting

### Problemas Comuns

1. **Health Connect não disponível**
   - Verifique se está instalado na Google Play Store
   - Confirme se o dispositivo tem Android 8.0+

2. **Permissões negadas**
   - Vá em Configurações > Apps > Health Connect > Permissões
   - Conceda acesso aos dados de passos

3. **Dados não aparecem**
   - Verifique a conexão com o smartwatch
   - Confirme se o relógio está sincronizando dados
   - Use os comandos de simulação para testes

4. **Erro de compilação**
   - Execute `flutter clean`
   - Execute `flutter pub get`
   - Verifique a versão do Flutter

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👥 Autores

- [Nome do Aluno 1]
- [Nome do Aluno 2]
- [Nome do Aluno 3] (se aplicável)

## 📞 Suporte

Para dúvidas ou problemas, abra uma issue no repositório ou entre em contato com os autores.
