package {
    import org.flixel.*;

    public class AutoTypeTextBox extends TextInputBox {
        public var running:Boolean = true;
        public var charCounter:int = 0;
        public var frame_lifetime:int = 0;
        public var toType:String;

        public function AutoTypeTextBox(origin:FlxPoint, width:Number, toType:String) {
            super(origin, width);
            this.toType = toType;
        }

        public function pressKey(name:String=""):void {
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
                if (this.frame_lifetime % 10 == 0) {
                    this.pressKey(this.toType.charAt(charCounter));
                    if (this.charCounter < this.toType.length) {
                        this.charCounter += 1;
                    }
                }
            }
        }

    }
}
