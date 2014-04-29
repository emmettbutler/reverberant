package
{
    import org.flixel.*;

    public class TextInputBox {
        [Embed(source="../assets/Perfect DOS VGA 437.ttf", fontFamily="Perfect DOS VGA 437", embedAsCFF="false")] public var FontDOS:Class;

        public var lastChar:TextNode = null;
        public var cursor:Cursor;
        public var keyMap:Array;
        public var printPos:FlxPoint;
        public var lineHeight:Number = 20;
        public var charWidth:Number = 10;
        public var width:Number = 600;
        public var _callback:Function;

        public function TextInputBox(origin:FlxPoint, width:Number) {
            this.width = width;

            keyMap = new Array();
            keyMap["COMMA"] = ",";
            keyMap["SPACE"] = " ";
            keyMap["PERIOD"] = ".";
            keyMap["QUOTE"] = "'";
            keyMap["SEMICOLON"] = ";";
            keyMap["NUMPADSLASH"] = "/";
            keyMap["ENTER"] = "\n";

            printPos = origin;

            cursor = new Cursor(printPos.x, printPos.y);
            FlxG.state.add(cursor);

            function keyPressCallback(name:String):void {
                var char:String = "";
                if (name == "BACKSPACE") {
                    FlxG.state.remove(lastChar);
                    lastChar = lastChar.prev;
                    printPos.x = lastChar.x + charWidth;
                    printPos.y = lastChar.y;
                } else if (name == "ENTER") {
                    printPos.y += lineHeight;
                    printPos.x = 10;
                } else if (name in keyMap) {
                    char = keyMap[name];
                } else {
                    char = name;
                }
                if (char != "") {
                    var txt:TextNode = new TextNode(printPos.x, printPos.y, 30, char);
                    txt.setFormat("Perfect DOS VGA 437",14,0xffffffff,"left");
                    FlxG.state.add(txt);
                    printPos.x += charWidth;
                    if (lastChar != null) {
                        lastChar.setNext(txt);
                    }
                    lastChar = txt;
                }
                if (printPos.x > width - charWidth) {
                    printPos.x = 10;
                    printPos.y += lineHeight;
                }

                cursor.x = printPos.x;
                cursor.y = printPos.y;
            }
            this._callback = keyPressCallback;
        }

        public function update():void {
        }
    }
}
