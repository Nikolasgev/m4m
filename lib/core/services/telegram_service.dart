import 'dart:js' as js; // Импортируем dart:js для работы с JavaScript

class TelegramService {
  static void initTelegramWebApp() {
    // Проверяем, запущено ли приложение в Telegram
    if (isTelegramWebApp()) {
      // Инициализируем Telegram Web App
      js.context.callMethod('Telegram.WebApp.ready');
    }
  }

  static bool isTelegramWebApp() {
    // Проверяем, существует ли объект Telegram.WebApp.initData
    return js.context['Telegram'] != null &&
        js.context['Telegram']['WebApp'] != null &&
        js.context['Telegram']['WebApp']['initData'] != null;
  }

  static void expand() {
    if (isTelegramWebApp()) {
      js.context.callMethod('Telegram.WebApp.expand');
    }
  }

  static void close() {
    if (isTelegramWebApp()) {
      js.context.callMethod('Telegram.WebApp.close');
    }
  }
}
