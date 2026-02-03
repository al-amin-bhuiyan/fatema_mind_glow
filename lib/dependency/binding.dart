import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/splash_controller/splash_controller.dart';
import '../controllers/login_controller/login_controller.dart';
import '../controllers/sign_up_controller/sign_up_controller.dart';
import '../controllers/reset_password_controller/reset_password_controller.dart';
import '../controllers/otp_screen_controller/otp_screen_controller.dart';
import '../controllers/inner_connection_controller/inner_connection_controller.dart';
import '../controllers/home_controller/home_controller.dart';
import '../controllers/reflect_controller/reflect_controller.dart';
import '../controllers/profile_controller/profile_controller.dart';
import '../views/profile/widgets/edit_profile/edit_profile_controller.dart';
import '../views/profile/widgets/subscription/subscription_controller.dart';
import '../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';

class Dependency {
  static void init() {
    Get.put<SplashController>(SplashController(), permanent: true);
    
    // Put CustomNavBarController as permanent (shared across screens)
    Get.put<CustomNavBarController>(CustomNavBarController(), permanent: true);
    
    // Lazy load LoginController when needed
    Get.lazyPut<LoginController>(() => LoginController());

    // Lazy load Subscription when needed
    Get.lazyPut<SubscriptionController>(() => SubscriptionController());
    
    // Lazy load SignUpController when needed
    Get.lazyPut<SignUpController>(() => SignUpController());
    
    // Lazy load ResetPasswordController when needed
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
    
    // Lazy load OtpScreenController when needed
    Get.lazyPut<OtpScreenController>(() => OtpScreenController());
    
    // Lazy load InnerConnectionController when needed
    Get.lazyPut<InnerConnectionController>(() => InnerConnectionController());
    
    // Lazy load HomeController when needed
    Get.lazyPut<HomeController>(() => HomeController());
    
    // Lazy load ReflectController when needed
    Get.lazyPut<ReflectController>(() => ReflectController());
    
    // Lazy load ProfileController when needed
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
