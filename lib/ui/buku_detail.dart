import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/model/buku.dart';
import 'package:perpustakaansekolah/ui/buku_page.dart';
import 'package:perpustakaansekolah/ui/buku_form.dart';
import 'package:perpustakaansekolah/bloc/buku_bloc.dart';
import 'package:perpustakaansekolah/widget/warning_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BukuDetail extends StatefulWidget {
  Buku buku;
  BukuDetail({this.buku});
  @override
  _BukuDetailState createState() => _BukuDetailState();
}

class _BukuDetailState extends State<BukuDetail> {
  var image1 = "";
  var image2 = "";
  var descBook = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Detail Buku'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              carouselImage(),
              appBar(),
              description(),
              _tombolHapusEdit()
            ],
          ),
        ));
  }

  Widget appBar() {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  widget.buku.penulisBuku,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                      color: Colors.black),
                ),
                Text(
                  widget.buku.judulBuku,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  widget.buku.kodeBuku,
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget carouselImage() {
    if (widget.buku.kodeBuku == "A002") {
      image1 =
          "https://upload.wikimedia.org/wikipedia/id/8/8e/Laskar_pelangi_sampul.jpg";
      image2 =
          "https://dispusip.pekanbaru.go.id/wp-content/uploads/2020/09/laskar.jpg";
    } else {
      image1 =
          "https://img.freepik.com/premium-psd/book-cover-mockup-template_68185-415.jpg?w=2000";
      image2 =
          "https://img.freepik.com/premium-psd/book-cover-mockup-template_68185-415.jpg?w=2000";
    }
    return CarouselSlider(
      items: [
        Container(
          margin: EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
            image: DecorationImage(
              image: NetworkImage(image1),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
            image: DecorationImage(
              image: NetworkImage(image2),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 400.0,
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeOutSine,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
    );
  }

  Widget description() {
    if (widget.buku.kodeBuku == 'A002') {
      descBook =
          "Laskar Pelangi adalah novel pertama karya Andrea Hirata yang diterbitkan oleh Bentang Pustaka pada tahun 2005. Novel ini bercerita tentang kehidupan 10 anak dari keluarga miskin yang bersekolah (SD dan SMP) di sebuah sekolah Muhammadiyah di Belitung yang penuh dengan keterbatasan";
    } else {
      descBook =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    }
    return Container(
        child: Text(
          descBook,
          textAlign: TextAlign.justify,
          style: TextStyle(height: 1.5, color: Colors.black),
        ),
        padding: EdgeInsets.all(16));
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Hapus
        ElevatedButton(
            child: Text("DELETE"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    // ignore: unnecessary_new
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        ElevatedButton(
          child: Text("Ya"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          onPressed: () {
            BukuBloc.deleteBuku(id: widget.buku.id).then((value) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => BukuPage()));
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: ((context) => WarningDialog(
                        description: "Hapus data gagal, silahkan coba lagi",
                      )));
            });
          },
        ),
        //tombol batal
        ElevatedButton(
          child: Text("Batal"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
