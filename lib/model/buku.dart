class Buku{
  int id;
  String kodeBuku;
  String judulBuku;
  String penulisBuku;

  Buku({this.id, this.kodeBuku, this.judulBuku, this.penulisBuku});

  factory Buku.fromJson(Map<String, dynamic> obj) {
    return Buku(
      id: obj['id'],
      kodeBuku: obj['kode_buku'],
      judulBuku: obj['judul_buku'],
      penulisBuku: obj['penulis_buku']
    );
  }
}