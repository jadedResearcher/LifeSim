import "../LifeSimLib.dart";
import "package:CommonLib/Colours.dart";

class Stat implements Comparable<Stat> {

    static List<Stat> allStats = new List<Stat>();

    Colour color;

    DateTime lastAccessed;
    int width = 100; //59
    int height = 165;
    int vialMaxHeight = 137;
    String name;
    //used for noble epitaphcs
    String title;
    String imageName = "images/vial.png";
    int _value = 0;
    int maxValue;
    String epitaphSentence;

    Stat(String this.name, String this.title, this.epitaphSentence, int this._value, this.color, [int this.maxValue = 10]) {
        lastAccessed = new DateTime.now();
        Stat.allStats.add(this);
    }

    static Stat findStatWithName(String name) {
        for(Stat s in Stat.allStats) {
            if(s.name == name) return s;
        }
        print("TINY WARNING LEVEL ERROR, COULDN'T FIND STAT WITH NAME $name");
        return null;
    }

    int get vialHeight {
        return (_value/maxValue * vialMaxHeight).round();
    }

    int get value => _value;

    void set value(value) {
        lastAccessed = new DateTime.now();
        _value = value;
        if(_value < 0) _value = 0;
    }

    //vial should have transparency, fill it up based on how full you are.
    Future<CanvasElement> renderSelf() async{
        //vial of liquid pointing up
        CanvasElement canvas = new CanvasElement(width: width, height: height);
        canvas.context2D.fillStyle = color.toStyleString();
        canvas.context2D.fillRect(0, height-vialHeight, width, vialHeight);
        await Renderer.drawWhateverFuture(canvas, imageName);
        return canvas;
    }
  @override
  int compareTo(Stat other) {
    return other.lastAccessed.millisecondsSinceEpoch - lastAccessed.millisecondsSinceEpoch;
  }
}