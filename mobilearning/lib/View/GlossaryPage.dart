// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, import_of_legacy_library_into_null_safe, unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilearning/Models/glossaryWordModel.dart';
import 'package:mobilearning/Widgets/GlossaryList.dart';
import 'package:http/http.dart';
import 'package:mobilearning/http/transactions/transaction_word.dart';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<GlossaryPage> createState() => _GlossaryPageState();
}
 
Future<List<GlossaryWord>> getWords() async {
  try {
    Options opt = Options();
    opt.headers = {
      "authorization":
          "bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiMDcyM2U5NDQtYjk1ZC00OGFjLTkxZTEtYzJlODgxODA2MDgyIiwibmJmIjoxNjYzODczNjgzLCJleHAiOjE2NjM4OTE2ODMsImlhdCI6MTY2Mzg3MzY4M30.ngMXg7RQpBsB1FL-CVxqQZVf8Is0-MLvtD_uI90FxC0"
    };
    var response = await Dio()
        .get('https://mobilearning-api.herokuapp.com/word', options: opt);
    List<GlossaryWord> words = [];

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.data);
      // print(body[0]['ID']);
      body.forEach((element) {
        words.add(GlossaryWord.fromJson(element));
      });

      print(words.length);
      return words;
    }
  } catch (e) {
    //print(e);
    List<GlossaryWord> words = [];
    return words;
  }
  List<GlossaryWord> words = [];
    return words;
}


class _GlossaryPageState extends State<GlossaryPage> {
  
  final TransactionWebClient _webClient = TransactionWebClient();

  //lista de dados completa
 List<GlossaryWord> words = [
   GlossaryWord (id: 1,userId:1, englishWord: "Book", portugueseWord: "Livro", englishDefinition:"Texts grouped into pages texts grouped into pages", portugueseDefinition:"Textos agrupados em paginas"),
  ];

  // lista de dados que sera exibida
  List<GlossaryWord> foundWords = [];


  // Função que é chamada quando o campo de texto muda
  void runFilter(String enteredKeyword) {
    List<GlossaryWord>  results = [];

     // Se o Campo de texto está em branco ou com apenas espaços exibe todos os registros
    if (enteredKeyword.isEmpty) {
      results = words;
    }
     else {
      // Preenche a nova lista de resultados apenas com os nomes que possuem o texto procurado
      results = words.where((word) => word.englishWord.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    // Refresh the UI
    setState(() {
      foundWords = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    


    return Padding(padding: EdgeInsets.all(20),
    child: Column(
      children: [const SizedBox(
        height: 20,
      ),
      
      TextField(onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
        labelText: 'Search a word', suffixIcon: Icon(Icons.search) ),
      ),

        GestureDetector(child: Padding(
                  padding: const EdgeInsets.only( left: 75.0, right: 75.0, top: 10.0, bottom: 0.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(21,93,177,1),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Add new Word",style: GoogleFonts.arvo(fontSize: 18, fontWeight: FontWeight.w400,color: Colors.white),),
                      Icon(Icons.add,color: Colors.white,) 
                    ],)
                    ),
                  ),
                ),
                onTap: ()=>{
                  setState((){
                    Navigator.pushNamed(context, "/cword");
                  })
                },
                ),

      const SizedBox(height: 20,),

      Expanded(
          child: FutureBuilder<List<GlossaryWord>>(
        future: getWords(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<GlossaryWord>? transactions = snapshot.data;
                if (transactions!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                            transactions[index].englishWord.toString(),
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transactions[index].portugueseWord,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Text(
                  'No transactions found',
                );
              }
          }
          return const Text('Unknow error');
        },
      ),
    ),
      ]
        )
        );

    
  
  }
}