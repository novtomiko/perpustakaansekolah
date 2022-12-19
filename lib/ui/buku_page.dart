import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/bloc/logout_bloc.dart';
import 'package:perpustakaansekolah/bloc/buku_bloc.dart';
import 'package:perpustakaansekolah/model/buku.dart';
import 'package:perpustakaansekolah/ui/login_page.dart';
import 'package:perpustakaansekolah/ui/buku_detail.dart';
import 'package:perpustakaansekolah/ui/buku_form.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:perpustakaansekolah/widget/form_dialog.dart';

class BukuPage extends StatefulWidget {
  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  @override
  Widget build(BuildContext context) {
    // return CarouselBuku();
    return Scaffold(
      appBar: AppBar(
        title: Text('List Buku'),
        backgroundColor: Colors.amber,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Icon(Icons.add, size: 26.0),
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return FormWidget();
                      });
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => LoginPage()))
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: BukuBloc.getBukus(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBuku(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListBuku extends StatelessWidget {
  final List list;
  ListBuku({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return ItemBuku(buku: list[i]);
        });
  }
}

class ItemBuku extends StatelessWidget {
  final Buku buku;

  ItemBuku({this.buku});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => BukuDetail(buku: buku)));
        },
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                iconBuku(),
                                SizedBox(height: 10.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      children: <Widget>[
                                        RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                                text: buku.judulBuku,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: ("\n" +
                                                          buku.penulisBuku),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                          fontStyle:
                                                              FontStyle.italic))
                                                ]))
                                      ],
                                    ),
                                  ),
                                )
                                // ListTile(
                                //   title: Text(buku.judulBuku),
                                //   subtitle: Text(buku.penulisBuku),
                                // )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // child: ListTile(
          //   title: Text(buku.judulBuku),
          //   subtitle: Text(buku.penulisBuku),
          // ),
        ),
      ),
    );
  }
}

Widget iconBuku() {
  return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.book_outlined,
          color: Colors.amber,
          size: 40,
        ),
      ));
}

class CarouselBuku extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        CarouselSlider(
          items: [
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2017/01/08/13/58/cube-1963036__340.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/03/25/23/46/cube-689619__340.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJqqqTEDG47DmRff3nNLGXTq5CpMgiPWaVfw56m-Ulnb86AT005TvuIaQB58jJURMKlHk&usqp=CAU"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
            height: 250.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
      ]),
    );
  }
}
