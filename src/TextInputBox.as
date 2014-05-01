package
{
    import org.flixel.*;

    public class TextInputBox {
        [Embed(source="../assets/Perfect DOS VGA 437.ttf", fontFamily="Perfect DOS VGA 437", embedAsCFF="false")] public var FontDOS:Class;

        public var lastChar:TextNode = null;
        public var cursor:Cursor;
        public var keyMap:Array;
        public var printed_string:String = "";
        public var printPos:FlxPoint;
        public var lineHeight:Number = 20;
        public var charWidth:Number = 8;
        public var width:Number = 600;
        public var _callback:Function;
        public var enterCallback:Function = null;
        public var enterPoemCallback:Function = null;
        public var origin:FlxPoint;
        public var charCounter:Number = 0;
        public var lines:LineGenerator;
        public var allows_linebreaks:Boolean = true;

        public var use_poem_line:Boolean = false;
        public var current_poem_line:String = "";

        public var dbgText:FlxText;

        public function TextInputBox(origin:FlxPoint, width:Number, lines:LineGenerator) {
            this.width = width;
            this.origin = origin;
            this.printPos = new FlxPoint(origin.x, origin.y);
            this.lines = lines;

            dbgText = new FlxText(100, 100, FlxG.width, "");
            dbgText.color = 0xffffffff;
            FlxG.state.add(dbgText);

            keyMap = new Array();
            keyMap["COMMA"] = ",";
            keyMap["SPACE"] = " ";
            keyMap["PERIOD"] = ".";
            keyMap["QUOTE"] = "'";
            keyMap["SEMICOLON"] = ";";
            keyMap["NUMPADSLASH"] = "/";
            keyMap["RBRACKET"] = "]";
            keyMap["LBRACKET"] = "[";
            keyMap["ONE"] = "1";
            keyMap["TWO"] = "2";
            keyMap["THREE"] = "3";
            keyMap["FOUR"] = "4";
            keyMap["FIVE"] = "5";
            keyMap["SIX"] = "6";
            keyMap["SEVEN"] = "7";
            keyMap["EIGHT"] = "8";
            keyMap["NINE"] = "9";
            keyMap["ZERO"] = "0";
            keyMap["ENTER"] = "\n";

            if (origin != null) {
                printPos.x = origin.x;
                printPos.y = origin.y;
            }

            cursor = new Cursor(printPos.x, printPos.y);
            FlxG.state.add(cursor);
        }

        public function keyPressCallback(name:String, auto:Boolean=false):void {
            if (this.use_poem_line && name != "ENTER") {
                name = this.current_poem_line.charAt(charCounter);
            }
            if (!auto) {
                charCounter++;
            }

            this.printInput(name);
        }

        public function lineBreak(edit_str:Boolean=true):void {
            if (edit_str) {
                this.printed_string += "\n";
            }
            printPos.y += lineHeight;
            printPos.x = 10;
        }

        public function printInput(name:String):void {
            var char:String = "";
            if (name == "BACKSPACE") {
                FlxG.state.remove(lastChar);
                if (printed_string.length > 1 && lastChar != null && lastChar.prev != null) {
                    lastChar = lastChar.prev;
                    printPos.x = lastChar.x + charWidth;
                    printPos.y = lastChar.y;
                } else if (printed_string.length <= 1) {
                    this.erase();
                }
                printed_string = printed_string.slice(0, -1);
            } else if (name == "ENTER") {
                if (this.use_poem_line && this.enterPoemCallback != null) {
                    this.enterPoemCallback(this.printed_string);
                } else if (!this.use_poem_line && this.enterCallback != null) {
                    this.enterCallback(this.printed_string);
                } else if (this.allows_linebreaks){
                    this.lineBreak();
                }
            } else if (name in keyMap) {
                char = keyMap[name];
            } else {
                char = name;
            }
            if (char.length > 1) {
                char = "";
            }

            if (char != "") {
                if (printPos.x < width - charWidth || this.allows_linebreaks) {
                    printed_string += char;
                    var txt:TextNode = new TextNode(printPos.x, printPos.y, 30, char);
                    txt.setFormat("Perfect DOS VGA 437",14,0xffffffff,"left");
                    FlxG.state.add(txt);
                    printPos.x += charWidth;
                    if (lastChar != null) {
                        lastChar.setNext(txt);
                    }
                    lastChar = txt;
                }
            }
            if (printPos.x > width - charWidth) {
                if (this.allows_linebreaks) {
                    this.lineBreak(false);
                }
            }

            cursor.x = printPos.x;
            cursor.y = printPos.y;
        }

        public function complete():void {
            this.erase();
            for (var i:int = 0; i < this.current_poem_line.length; i++) {
                this.keyPressCallback(this.current_poem_line.charAt(i));
            }
        }

        public function erase():void {
            var cur:TextNode = this.lastChar;
            var next:TextNode;
            while (cur != null) {
                next = cur.prev;
                FlxG.state.remove(cur);
                cur = next;
            }
            printed_string = "";
            printPos.x = origin.x;
            printPos.y = origin.y;
            cursor.x = printPos.x;
            cursor.y = printPos.y;
            charCounter = 0;
        }

        public function update():void {
        }
    }
}
