package {
    import org.flixel.*;

    public class AutoTypeTextBox extends TextInputBox {
        public var running:Boolean = true;
        public var charCounter:int = 0;
        public var frame_lifetime:int = 0;
        public var toType:String;
        public var invertedKeys:Array;
        public var speed:Number = 20;

        public function AutoTypeTextBox(origin:FlxPoint, width:Number, toType:String) {
            super(origin, width);
            this.toType = toType;

            this.invertedKeys = new Array();

            for (var k:String in this.keyMap) {
                this.invertedKeys[this.keyMap[k]] = k
            }
        }

        public function pressKey(name:String=""):void {
            if (name in this.invertedKeys) {
                name = this.invertedKeys[name];
            }
            this.keyPressCallback(name);
        }

        public function typeString(toType:String):void {
            this.running = true;
            this.toType = toType;
            this.charCounter = 0;
        }

        override public function update():void {
            this.frame_lifetime += 1;

            dbgText.text = "running: " + this.running + "\ncharCounter: " + this.charCounter + "\ntoType: " + this.toType + "\nframes: " + this.frame_lifetime + "\norigin: " + this.origin.x + "," + this.origin.y;
            if (this.running) {
                if (this.frame_lifetime % this.speed == 0) {
                    this.pressKey(this.toType.charAt(this.charCounter));
                    if (this.charCounter < this.toType.length) {
                        this.charCounter++;
                    }
                }
            }
        }

    }
}
