import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perpustakaansekolah/bloc/logout_bloc.dart';
import 'package:perpustakaansekolah/bloc/buku_bloc.dart';
import 'package:perpustakaansekolah/model/buku.dart';
import 'package:perpustakaansekolah/ui/login_page.dart';
import 'package:perpustakaansekolah/ui/buku_detail.dart';
import 'package:perpustakaansekolah/ui/buku_form.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => BukuForm()));
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
      body: CarouselBuku(),
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => BukuDetail(buku: buku)));
        },
        child: Card(
          child: ListTile(
            title: Text(buku.judulBuku),
            subtitle: Text(buku.penulisBuku),
          ),
        ),
      ),
    );
  }
}

class CarouselBuku extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        FutureBuilder<List>(
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
