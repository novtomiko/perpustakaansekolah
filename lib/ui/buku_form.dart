import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/model/buku.dart';
import 'package:perpustakaansekolah/bloc/buku_bloc.dart';
import 'package:perpustakaansekolah/ui/buku_page.dart';
import 'package:perpustakaansekolah/widget/warning_dialog.dart';

class BukuForm extends StatefulWidget {
  Buku buku;
  BukuForm({this.buku});
  @override
  _BukuFormState createState() => _BukuFormState();
}

class _BukuFormState extends State<BukuForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH BUKU";
  String tombolSubmit = "SIMPAN";

  final _kodeBukuTextboxController = TextEditingController();
  final _judulBukuTextboxController = TextEditingController();
  final _penulisBukuTextboxController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUpdate();
  }

  isUpdate(){
    if(widget.buku!=null){
      setState(() {
        judul = "UBAH BUKU";
        tombolSubmit = "UBAH";
        _kodeBukuTextboxController.text = widget.buku.kodeBuku;
        _judulBukuTextboxController.text = widget.buku.judulBuku;
        _penulisBukuTextboxController.text = widget.buku.penulisBuku;
      });
    }else{
      judul = "TAMBAH BUKU";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Container(
          child: Padding (
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _kodeBukuTextField(),
                  _judulBukuTextField(),
                  _penulisBukuTextField(),
                  _buttonSubmit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Buku
  Widget _kodeBukuTextField(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Kode Buku"),
      keyboardType: TextInputType.text,
      controller: _kodeBukuTextboxController,
      validator: (value) {
        if (value.isEmpty) {
          return "Kode Buku harus diisi";
        }
        return null;
      }
    );
  }

  //Membuat Textbox judul Buku
  Widget _judulBukuTextField(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Judul Buku"),
      keyboardType: TextInputType.text,
      controller: _judulBukuTextboxController,
      validator: (value) {
        if (value.isEmpty) {
          return "Judul Buku harus diisi";
        }
        return null;
      }
    );
  }

  //Membuat Textbox penulis buku
  Widget _penulisBukuTextField(){
            return TextFormField(
              decoration: InputDecoration(labelText: "Penulis Buku"),
              keyboardType: TextInputType.number,
              controller: _penulisBukuTextboxController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Penulis buku harus diisi";
                }
                return null;
              },
            );
          }
          
          simpan() {
            setState(() {
              _isLoading = true;
            });
            Buku createBuku = new Buku();
            createBuku.kodeBuku = _kodeBukuTextboxController.text;
            createBuku.judulBuku = _judulBukuTextboxController.text;
            createBuku.penulisBuku = _penulisBukuTextboxController.text;
            BukuBloc.addBuku(buku: createBuku).then((value) {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> BukuPage()));
            },onError: (error){
              showDialog(
                  context: this.context,
                  builder: (BuildContext context) => WarningDialog(
                    description: "Simpan gagal, silahkan coba lagi",
                  )
                );
          });
          setState(() {
            _isLoading = false;
          });
        }
          //Membuat Tombol Simpan/Ubah
          Widget _buttonSubmit() {
            return RaisedButton(
              child: Text(tombolSubmit),
              onPressed: () {
                var validate = _formKey.currentState.validate();
                if(validate) {
                  if(!_isLoading) {
                    if(widget.buku!=null){
                      //kondisi update buku
                    }else{
                      //kondisi tambah buku
                      simpan();
                    }
                  }
                }
              });

}
          ubah() {
            setState(() {
              _isLoading = true;
            });
            Buku updateBuku = new Buku();
            updateBuku.id = widget.buku.id;
            updateBuku.kodeBuku = _kodeBukuTextboxController.text;
            updateBuku.judulBuku = _judulBukuTextboxController.text;
            updateBuku.penulisBuku = _penulisBukuTextboxController.text;
            BukuBloc.updateBuku(buku: updateBuku).then((value) {
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> BukuPage()));
            },onError: (error){
              showDialog(
                context: context,
                builder: (BuildContext context) => WarningDialog (
                  description: "Permintaan ubah data gagal, silahkan coba lagi",
                )  
              );
            });
            setState((){
              _isLoading = false;
            });
          }
}