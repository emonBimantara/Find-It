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

    final url = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Could not open WhatsApp");
    }
  }
}
