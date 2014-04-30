package {
    import org.flixel.*;

    public class TimeCounter {
        public var frame_lifetime:Number;
        public var frames_remaining:Number;
        public var total_frames:Number;

        public var origin:FlxPoint;
        public var width:Number;

        public var pieces:Array;
        public static var NUM_SEGMENTS:Number = 15;
        public var segment_width:Number = 10;

        public var last_index:Number = NUM_SEGMENTS - 1;

        public function TimeCounter(origin:FlxPoint, width:Number) {
            this.pieces = new Array();
            this.frames_remaining = this.total_frames;
            this.segment_width = width / NUM_SEGMENTS;
            this.width = width;
            for (var i:int = 0; i < NUM_SEGMENTS; i++) {
                var segment:FlxSprite = new FlxSprite(origin.x+(this.segment_width*i), origin.y);
                segment.makeGraphic(this.segment_width, 15, 0xffffffff);
                FlxG.state.add(segment);
                this.pieces.push(segment);
            }
        }

        public function set_time(frames:Number):void {
            this.frames_remaining = frames;
            this.total_frames = frames;
        }

        public function update():void {
            this.frame_lifetime++;
            if (this.frames_remaining > 0) {
                this.frames_remaining--;
            }

            var pct:Number = this.frames_remaining / this.total_frames;
            var per_segment:Number = this.total_frames / NUM_SEGMENTS;
            for (var i:int = 0; i < this.pieces.length; i++) {
                var flr:Number = i*per_segment;
                var cil:Number = (i+1)*per_segment
                var piece:FlxSprite = this.pieces[i];
                if (this.frames_remaining > flr) {
                    piece.alpha = 1;
                } else {
                    piece.alpha = 0;
                }
            }
        }
    }
}
