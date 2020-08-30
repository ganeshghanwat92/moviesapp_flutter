
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SecondPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: SecondPageContents(),
    );
  }
}

class SecondPageContents extends StatefulWidget {
  @override
  _SecondPageContentsState createState() => _SecondPageContentsState();
}

class _SecondPageContentsState extends State<SecondPageContents> {
  String textToShow = "I like flutter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _demoExamples()),
    );
  }

  Widget _demoExamples() {
    return Column(
      children: <Widget>[
        MaterialButton(
          child: Text("Update Text Wedget demo"),
          onPressed: _navigateToUpdateTextExample,
        ),
        MaterialButton(
          child: Text("Animation Example"),
          onPressed: _navigateToAnimationExample,
        ),
        MaterialButton(
          child: Text("Paint Example"),
          onPressed: _navigateToPaintExample,
        ),
      ],
    );
  }

  void _navigateToUpdateTextExample() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UpdateTextWidgetExample()));
  }

  void _navigateToAnimationExample() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AnimationExample()));
  }

  void _navigateToPaintExample() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PaintExample()));
  }
}

class UpdateTextWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Text Wedget demo"),
      ),
      body: UpdateTextWidget(),
    );
  }
}

class UpdateTextWidget extends StatefulWidget {
  @override
  _UpdateTextWidgetState createState() => _UpdateTextWidgetState();
}

class _UpdateTextWidgetState extends State<UpdateTextWidget> {
  String textToShow = "I like flutter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(textToShow)),
      floatingActionButton: FloatingActionButton(
        tooltip: "Update Text",
        child: Icon(Icons.update),
        onPressed: _updateText,
      ),
    );
  }

  void _updateText() {
    setState(() {
      textToShow = "Welcome to Flutter " +
          DateTime.now().millisecondsSinceEpoch.toString();
    });
  }
}

// -----------------------------------------------------------------------------------------------------------------------------------//

class AnimationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationExampleWidget(
        title: "Fade Demo",
      ),
    );
  }
}

class AnimationExampleWidget extends StatefulWidget {
  AnimationExampleWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AnimationExampleWidgetState createState() => _AnimationExampleWidgetState();
}

class _AnimationExampleWidgetState extends State<AnimationExampleWidget>
    with TickerProviderStateMixin {
  AnimationController animationController;
  CurvedAnimation curvedAnimation;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: FadeTransition(
            opacity: curvedAnimation,
            child: FlutterLogo(
              size: 100.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Fade",
        child: Icon(Icons.brush),
        onPressed: () {
          animationController.forward();
        },
      ),
    );
  }
}

//----------------------------------------------- --------------------------------------------------------------------------------------//

class PaintExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paint Example"),
      ),
      body: DrawSignatureWidget(),
    );
  }
}

class DrawSignatureWidget extends StatefulWidget {
  @override
  _DrawSignatureWidgetState createState() => _DrawSignatureWidgetState();
}

class _DrawSignatureWidgetState extends State<DrawSignatureWidget> {
  List<Offset> _points = <Offset>[];

  Color selectedColor = Colors.black;

  static const directoryName = 'Signature';

  String _platformVersion = 'Unknown';

  Size paintSize = Size.square(400);


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              Offset localPosition =
                  renderBox.globalToLocal(details.globalPosition);
              _points = List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) {
            _points.add(null);
          },
          child: CustomPaint(
            painter:
                SignaturePainter(points: _points, paintColor: selectedColor),
            size: paintSize,
          ),
        ),
        Row(
          children: <Widget>[
            MaterialButton(
              height: 60,
              minWidth: 60,
              color: Colors.black,
              onPressed: () {
                selectedColor = Colors.black;
              },
            ),
            MaterialButton(
              height: 60,
              minWidth: 60,
              color: Colors.blue,
              onPressed: () {
                selectedColor = Colors.blue;
              },
            ),
            MaterialButton(
              height: 60,
              minWidth: 60,
              color: Colors.red,
              onPressed: () {
                selectedColor = Colors.red;
              },
            ),
            MaterialButton(
              height: 60,
              minWidth: 60,
              color: Colors.green,
              onPressed: () {
                selectedColor = Colors.green;
              },
            ),
            MaterialButton(
              height: 60,
              minWidth: 60,
              color: Colors.amber,
              onPressed: () {
                selectedColor = Colors.amber;
              },
            )
          ],
        ),
        Row(children: <Widget>[
          RaisedButton(
            child: Text("Clear"),
            onPressed: () {
              setState(() {
                _points = [];
              });
            },
          ),
          RaisedButton(
            child: Text("Undo"),
            onPressed:  _undoButtonPress()   /* () {
              setState(() {
                if(_points.isEmpty)
                  return null;
                else
                _points.removeLast();
              });
            }*/,
          ),
          RaisedButton(
            child: Text("Save"),
            onPressed: () {

              _saveImage(context);
            },
          )
        ]),
      ]),
    );
  }

  _saveImage(BuildContext context) async{

  ui.Image image =  await rendered;

  showImage(context, image);

  }

  Future<Null> showImage(BuildContext context, ui.Image image) async {
    var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    // Use plugin [path_provider] to export image to storage
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    print(path);
    await Directory('$path/$directoryName').create(recursive: true);
    File('$path/$directoryName/${formattedDate()}.png')
        .writeAsBytesSync(pngBytes.buffer.asInt8List());
    return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Please check your device\'s Signature folder',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.1
              ),
            ),
            content: Image.memory(Uint8List.view(pngBytes.buffer)),
          );
        }
    );
  }

  String formattedDate() {
    DateTime dateTime = DateTime.now();
    String dateTimeString = 'Signature_' +
        dateTime.year.toString() +
        dateTime.month.toString() +
        dateTime.day.toString() +
        dateTime.hour.toString() +
        ':' + dateTime.minute.toString() +
        ':' + dateTime.second.toString() +
        ':' + dateTime.millisecond.toString() +
        ':' + dateTime.microsecond.toString();
    return dateTimeString;
  }

 Function _undoButtonPress(){
    if (_points.isEmpty) {
      return null;
    } else {
      return () {
        // do anything else you may want to here
        setState(() {
          _points.removeLast();
        });
      };
    }
  }

  Future<ui.Image> get rendered {
    // [CustomPainter] has its own @canvas to pass our
    // [ui.PictureRecorder] object must be passed to [Canvas]#contructor
    // to capture the Image. This way we can pass @recorder to [Canvas]#contructor
    // using @painter[SignaturePainter] we can call [SignaturePainter]#paint
    // with the our newly created @canvas
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(points: _points, paintColor: selectedColor);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder.endRecording().toImage(size.width.floor(), size.height.floor());
  }

}

class SignaturePainter extends CustomPainter {
  SignaturePainter({this.points, this.paintColor});

  final List<Offset> points;
  final Color paintColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = paintColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
    paint.style=PaintingStyle.stroke;
    paint.color = Colors.black;
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);

  }

  @override
  bool shouldRepaint(SignaturePainter signaturePainter) {
    return signaturePainter.points != points;
  }
}


// ---------------------------------------------------------------------------------------------------------------------------------------------

