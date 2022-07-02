import 'package:fl_newsapp/src/models/news_model.dart';
import 'package:flutter/material.dart';

class ListaNoticias extends StatelessWidget {
  const ListaNoticias({Key? key, required this.noticias}) : super(key: key);

  final List<Article> noticias;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;
  
  const _Noticia({
    required this.noticia,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        _TarjetaTopBar(noticia: noticia, index: index),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        const _TarjetaBotones(),
        const SizedBox(height: 10),
        const Divider()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(Icons.star_border),
          ),
          const SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: const Icon(Icons.more),
          )
        ],
      )
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  const _TarjetaBody({
    Key? key,
    required this.noticia
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(noticia.description ?? '')
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  const _TarjetaImagen({
    Key? key,
    required this.noticia
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (noticia.urlToImage != null)
          ? FadeInImage(
              placeholder: const AssetImage('assets/giphy.gif'),
              image: NetworkImage(noticia.urlToImage!)
            )
          : const Image(image: AssetImage('assets/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  const _TarjetaTitulo({
    Key? key,
    required this.noticia
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  const _TarjetaTopBar({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget> [
          Text('${index + 1}. ', style: const TextStyle(color: Colors.red)),
          Text('${noticia.source.name}. ')
        ]
      )
    );
  }
}