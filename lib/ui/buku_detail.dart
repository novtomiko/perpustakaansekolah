import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/model/buku.dart';
import 'package:perpustakaansekolah/ui/buku_page.dart';
import 'package:perpustakaansekolah/ui/buku_form.dart';
import 'package:perpustakaansekolah/bloc/buku_bloc.dart';
import 'package:perpustakaansekolah/widget/warning_dialog.dart';

class BukuDetail extends StatefulWidget {
  Buku buku;
  BukuDetail({this.buku});
  @override
  _BukuDetailState createState() => _BukuDetailState();
}

class _BukuDetailState extends State<BukuDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.buku.kodeBuku}",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.buku.judulBuku}",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.buku.penulisBuku}",
              style: TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),  
    );
  }

  Widget _tombolHapusEdit(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        RaisedButton(
            child: Text("EDIT"), color: Colors.green, onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => BukuForm(buku: widget.buku,)));
            }),
            //Tombol Hapus
            RaisedButton(
                child: Text("DELETE"), color: Colors.red, onPressed: ()=>confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    // ignore: unnecessary_new
    AlertDialog alertDialog = new AlertDialog(
      content: Text ("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        RaisedButton(
          child: Text("Ya"),
          color: Colors.green,
          onPressed: (){
            BukuBloc.deleteBuku(id: widget.buku.id).then((value){
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> BukuPage()));
            },onError: (error){
                showDialog(
                  context: context,
                  builder: ((context) => WarningDialog(
                    description: "Hapus data gagal, silahkan coba lagi",
                  )
              ));
            });
          },
      ),
        //tombol batal
        RaisedButton(
          child: Text("Batal"),
          color: Colors.red,
          onPressed: ()=>Navigator.pop(context),
        )
      ],
    );
    

    showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }
}