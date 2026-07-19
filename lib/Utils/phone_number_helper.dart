class PhoneNumberHelper {
  static String normalize(String phone) {
    phone = phone.replaceAll(RegExp(r'[^0-9]'), '');

    if (phone.startsWith('0')) {
      phone = '62${phone.substring(1)}';
    }

    if (phone.startsWith('620')) {
      phone = '62${phone.substring(3)}';
    }

    return phone;
  }

  static String formatDisplay(String phone) {
    final normalized = normalize(phone);

    if (normalized.startsWith('62')) {
      return '+$normalized';
    }

    return phone;
  }
}
