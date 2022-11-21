class ApiUrl {
  static const String baseUrl = 'http://10.0.2.2/perpustakaan-api/public';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listBuku = baseUrl + '/buku';
  static const String createBuku = baseUrl + '/buku';

  static String updateBuku(int id) {
    return baseUrl + '/buku/' + id.toString() + '/update';
  }

  static String showBuku(int id) {
    return baseUrl + '/buku/' + id.toString();
  }

  static String deleteBuku(int id) {
    return baseUrl + '/buku/' + id.toString();
  }
}