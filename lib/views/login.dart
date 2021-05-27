import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx/models/usuario.dart';
import 'package:olx/views/input_customizado.dart';



class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController(text: "luestevam@hotmail.com");
  TextEditingController _controllerSenha = TextEditingController(text: "1234567");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textBotao = "Entrar";


  _cadastrarUsuario (Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){
      
      //redirencionar para tela principal
      Navigator.pushReplacementNamed(context, "/");

     });
  }

  _logarUsuario (Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

    });
  }



  _validarCampos() {

    //Recuperar Dados do campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {

        //Configura Usuário
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        //Cadastrar ou logar
        if( _cadastrar ) {
          //Cadastro
          _cadastrarUsuario(usuario);
        }else{
          //Logar
          _logarUsuario(usuario);
        }


      } else{
        setState(() {
          _mensagemErro = "Preenhca a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:<Widget> [
                Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Image.asset("images/logo.png",
                    width: 200,
                    height: 150,),
                ),
                
                InputCustomizado(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                    ),

                InputCustomizado(
                  controller: _controllerSenha,
                  hint: "Senha",
                  obscure: false,
                  autofocus: true,
                  type: TextInputType.text,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text ("Logar"),
                    Switch(value: _cadastrar,
                        onChanged: (bool valor){
                      setState(() {
                      _cadastrar = valor;
                      _textBotao = "Entrar";
                      if(_cadastrar) {
                        _textBotao = "Cadastrar";
                      }
                      });
                    }
                    ),
                    Text("Cadastrar"),
                  ],
                ),
                RaisedButton(
                  child: Text(
                    _textBotao,
                    style: TextStyle(
                      color: Colors.white, fontSize: 20
                    ),
                  ),
                    color: Color(0xff9c27b0),
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: (){
                    _validarCampos();
                  },

                ),
                Padding(
                    padding: EdgeInsets.only(top:20),
                child: Text(_mensagemErro, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                   ),
                 ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}


