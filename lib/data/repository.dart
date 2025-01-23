import '../core/services/local_sore_service.dart';
import '../core/services/notification_service.dart';
import '../env/environment.dart';
import 'local_store_service_impl.dart';
import 'notification_service_impl.dart';

class AppRepository {
  AppRepository(this.env);

  final Environment env;

  late final NotificationService notificationService;
  LocalStoreService localStoreService = LocalStoreServiceImpl();


  Future<void> init() async {
    notificationService = NotificationServiceImpl();
     localStoreService = LocalStoreServiceImpl();

  }
}
