import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/model/buku.dart';
import 'package:perpustakaansekolah/bloc/buku_bloc.dart';
import 'package:perpustakaansekolah/ui/buku_page.dart';
import 'package:perpustakaansekolah/widget/warning_dialog.dart';

class FormWidgetEdit extends StatefulWidget {
  Buku buku;
  FormWidgetEdit(Buku bukuParam);
  @override
  _FormWidgetEditState createState() => _FormWidgetEditState();
}

class _FormWidgetEditState extends State<FormWidgetEdit> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Edit Buku";
  String tombolSubmit = "Simpan";

  final _kodeBukuTextboxController = TextEditingController();
  final _judulBukuTextboxController = TextEditingController();
  final _penulisBukuTextboxController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      title: const Text('Edit Buku'),
      content: SizedBox(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                    controller: _kodeBukuTextboxController,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.bookmark_add_sharp, color: Colors.amber),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Kode Buku',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Kode Buku harus diisi";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                    controller: _judulBukuTextboxController,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.book_outlined, color: Colors.amber),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Judul Buku',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Judul Buku harus diisi";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                    controller: _penulisBukuTextboxController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.amber,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Penulis Buku',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Penulis buku harus diisi";
                      }
                      return null;
                    })
              ],
            )),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.amber,
            ),
            onPressed: () {
              var validate = _formKey.currentState.validate();
              if (validate) {
                if (!_isLoading) {
                  //kondisi update buku
                  ubah();
                }
              }
            },
            child: const Text(
              'Simpan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
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
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => BukuPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
