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
}
