package {
    import flash.events.KeyboardEvent;
    import org.flixel.*;
    import org.flixel.system.input.*;

    public class Inputter extends Keyboard {
        public var callback:Function;

        public function Inputter(callback:Function) {
            this.callback = callback;
        }

        override public function handleKeyDown(FlashEvent:KeyboardEvent):void {
            super.handleKeyDown(FlashEvent);

            var object:Object = _map[FlashEvent.keyCode];
            var keyCode:Number = _lookup[object.name];
            this.callback(object.name, keyCode);
        }
    }
}
