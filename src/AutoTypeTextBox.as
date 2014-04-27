package {
    import org.flixel.*;

    public class AutoTypeTextBox extends TextInputBox {
        public var running:Boolean = true;
        public var charCounter:int = 0;
        public var frame_lifetime:int = 0;
        public var toType:String;
        public var invertedKeys:Array;

        public var dbgText:FlxText;

        public function AutoTypeTextBox(origin:FlxPoint, width:Number, toType:String) {
            super(origin, width);
            this.toType = toType;

            this.invertedKeys = new Array();

            dbgText = new FlxText(100, 100, 30, "");
            dbgText.color = 0xffffffff;
            FlxG.state.add(dbgText);

            for (var k:String in this.keyMap) {
                this.invertedKeys[this.keyMap[k]] = k
            }
        }

        public function pressKey(name:String=""):void {
            if (name in this.invertedKeys) {
                name = this.invertedKeys[name];
            }
            this._callback(name);
        }

        public function typeString(toType:String):void {
            for(var i:int; i < toType.length; i++) {
                this.pressKey(toType[i]);
            }
        }

        override public function update():void {
            this.frame_lifetime += 1;

            if (this.running) {
                if (this.frame_lifetime % 20 == 0) {
                    this.pressKey(this.toType.charAt(charCounter));
                    if (this.charCounter < this.toType.length) {
                        this.charCounter += 1;
                    }
                }
            }
        }

    }
}
