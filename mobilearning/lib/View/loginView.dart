import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.grey[250],
        body: 
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                //hello
                ImageIcon(AssetImage('assets/images/IEI.png'),
                color: Color.fromARGB(255, 153, 13, 13),
                size: 250,
                ),
              
                Text(
                  "Bem vindo",
                  style: GoogleFonts.arvo(fontSize: 25, color: Color.fromARGB(255, 104, 104, 104)),
                  
                ),
                SizedBox(
                  height: 10,
                ),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:"E-mail"),
                          style: GoogleFonts.arvo(fontSize: 18),
                        
                      ),
                    ),
                  ),
                ),
                //password textfield
                SizedBox(height: 25,),
                                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:"Senha"),
                          style: GoogleFonts.arvo(fontSize: 18),
                        
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                   padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 153, 13, 13),
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text("Entrar",
                    style: GoogleFonts.arvo(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.white),) 
                    ),
                  ),
                ),
              SizedBox(height: 5,),
              Column(
                children: [
                  Text("Esqueceu a senha", style: GoogleFonts.arvo(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.blue,)),
                ],
              )
                //Recover Password button
              ],
            ),
          ),
        ));
  }
}
