import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}
class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt,Color btncolor,Color txtcolor) //aqui asignamos los atributos de cada botones
  {
    return  Container(
      child: RaisedButton(
        onPressed: (){
        calculation(btntxt);
        }, 
        child: Text('$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
    //se le dio estilos a los botones, espaciados, forma circular y tamaños
  }
  @override
  Widget build(BuildContext context) {
    //apartir de aqui creamos la pantalla y le damos atributos de color, alineamos los textos y botones
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Pantalla
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                      //Texto del resultado
                    ),
                  ),
                  )
                ],
              ),
            ),
            //apartir de aqui le damos los atributos a los botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('AC',Colors.black,Colors.white),
                calcbutton('%',Colors.blue,Colors.white),
                calcbutton('/',Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7',Colors.black,Colors.white),
                calcbutton('8',Colors.black,Colors.white),
                calcbutton('9',Colors.black,Colors.white),
                calcbutton('x',Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4',Colors.black,Colors.white),
                calcbutton('5',Colors.black,Colors.white),
                calcbutton('6',Colors.black,Colors.white),
                calcbutton('-',Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1',Colors.black,Colors.white),
                calcbutton('2',Colors.black,Colors.white),
                calcbutton('3',Colors.black,Colors.white),
                calcbutton('+',Colors.blue,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              
                RaisedButton(
                padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                onPressed: (){
                calculation('0');
                }, //boton cero
                shape: StadiumBorder(),
                child: Text('0',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white),
                ),
                color: Colors.black,
                ),
                calcbutton('.',Colors.black,Colors.white),
                calcbutton('=',Colors.red,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  //Logica
  dynamic text ='0';
  double numUno = 0;
  double numDos = 0;

  dynamic result = '';
  dynamic ResultadoFinal = '';
  dynamic opr = '';
  dynamic preOpr = '';
   void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numUno = 0;
      numDos = 0;
      result = '';
      ResultadoFinal = '0';
      opr = '';
      preOpr = '';

      //reiniciamos las variables
    
    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
         ResultadoFinal = add();
      } else if( preOpr == '-') {
          ResultadoFinal = sub();
      } else if( preOpr == 'x') {
          ResultadoFinal = mul();
      } else if( preOpr == '/') {
          ResultadoFinal = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=')//verifica que signo se esta utilizando
     {

      if(numUno == 0) {
          numUno = double.parse(result);
      } else {
          numDos = double.parse(result);
      }

      if(opr == '+') {
          ResultadoFinal = add();
      } else if( opr == '-') {
          ResultadoFinal = sub();
      } else if( opr == 'x') {
          ResultadoFinal = mul();
      } else if( opr == '/') {
          ResultadoFinal = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numUno / 100;
     ResultadoFinal = conDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      ResultadoFinal = result;
    }
    
   
    
    else {
        result = result + btnText;
        ResultadoFinal = result;     
        //acumulacion del resultados si no se a reiniciado   
    }


    setState(() {
          text = ResultadoFinal;
        });

  }


  String add() {
         result = (numUno + numDos).toString();
         numUno = double.parse(result);           
         return conDecimal(result);
  }

  String sub() {
         result = (numUno - numDos).toString();
         numUno = double.parse(result);
         return conDecimal(result);
  }
  String mul() {
         result = (numUno * numDos).toString();
         numUno = double.parse(result);
         return conDecimal(result);
  }
  String div() {
          result = (numUno / numDos).toString();
          numUno = double.parse(result);
          return conDecimal(result);
  }


  String conDecimal(dynamic result) {
    
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }

    //operaciones con decimales
    return result; 
  }

}
