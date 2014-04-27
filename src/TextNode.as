package
{
    import org.flixel.*;

    public class TextNode extends FlxText {
        public var next:TextNode;
        public var prev:TextNode;

        public function TextNode(x:int, y:int, width:int, txt:String) {
            super(x, y, width, txt);
            this.next = null;
            this.prev = null;
        }

        public function setNext(node:TextNode):void {
            this.next = node;
            this.next.prev = this;
        }

        override public function update():void {
        }
    }
}
