import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailController extends GetxController {
  Future<void> contactReporter({
    required String phoneNumber,
    required String username,
    required String itemTitle,
  }) async {
    final message =
        "Hi $username, I saw your report about '$itemTitle' on FindIt. I think this might be my item.";

    final uri = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
    );

    final success = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!success) {
      throw Exception("Could not open WhatsApp");
    }
  }
}
