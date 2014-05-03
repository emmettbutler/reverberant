package {
    import org.flixel.*;

    public class LineGenerator {
        public var normal_lines:Array;
        public var poem_lines:Array;

        public var poem_counter:Number;
        public var line_counter:Number = 0;
        public var inv_poem_prob:Number = 5;

        public function LineGenerator() {
            this.normal_lines = new Array(
                "mov [recvbuflen]",
                "dword oxffff len comp",
                "push dword [socketarray]",
                "call recv packet",
                "add esp, 4",
                "test eax, eax",
                "js syn scan next batch",
                "movzx eax",
                "byte [recvbuf]",
                "and eax, oxf",
                "shl eax, 2 lin",
                "mov edi, eax mov",
                "add eax, 13 push",
                "lea esi, [recvbuf eax]",
                "lodsb eax exc",
                "and al, ox12",
                "cmp al, ox12",
                "jne syn scan recv",
                "reply jne loop",
                "push dword port",
                "open fmtstr wlk",
                "movzx eax, word",
                "[recvbuf edi]",
                "xchg al, ah",
                "push eax dword ptr",
                "call print port",
                "add esp, 8 stackptr",
                "eax stackpush",
                "mov rax, o dword ptr",
                "mov rdi, 1 bng",
                "lock cmpxchg [queue futex]",
                "cmp rax, o ecx tst",
                "je mutex enter end",
                "mutex enter begin",
                "cmp rax, 2 mov pop",
                "je mutex cond var",
                "mov rax, 1 exc",
                "mov rdi, 2 bit word",
                "lock cmpxchg ptrstack",
                "cmp rax, 1 buta",
                "je mutex ebp for",
                "mutex enter cont",
                "mov rcx, o vec2",
                "ld rdi, 2 word",
                "step cmpxchg [rdi",
                "cmp rax, o vec2",
                "jne mutex word st",
                "jmp mutex ba eax",
                "mutex enter wait",
                "mov rdi, 2 futex",
                "call sys futex weax",
                "jmp mutex ebx cont",
                "mutex enter end",
                "mbp stackpop",
                "ret eax ecx"
            );
            this.poem_lines = new Array(
                "the walk to work was slow",
                "shuffled your feet",
                "breathed a lot",
                "on the train nervously tap phone",
                "nothing to be done",
                "anything could happen right now",
                "and you wouldn't see it coming",
                "and that would be it for you",
                "you made a cup of tea at work",
                "breathing heavily",
                "having the internet",
                "doesn't sound appealing",
                "when it makes your heart pound",
                "the feeling doesn't go away all day",
                "focusing on work doesn't happen",
                "distracting yourself from yourself",
                "every once in a while",
                "you remember the fear",
                "typing a line",
                "and the words aren't right",
                "it's the same word twice",
                "as hands pretend it's fine",
                "it doesn't feel real",
                "to be in a panic at your desk",
                "wondering if anyone notices",
                "each bodypart tenses to the limit",
                "hold back purposeless sobs",
                "a physical reaction",
                "of terror",
                "get up hiding your face",
                "walk quickly to the bathroom",
                "lock the door",
                "open the window",
                "to the taut street",
                "with only a faint idea of",
                "what you're doing or why",
                "it's easier after that",
                "you get some work done",
                "order the computer around",
                "knowing that at any moment",
                "you'll become subhuman"
            );
            this.poem_counter = 0;
            //this.poem_counter = this.poem_lines.length - 5;
        }

        public function get_next():String {
            this.line_counter++;
            if (this.line_counter % 4 == 0 && this.inv_poem_prob > 1) {
                this.inv_poem_prob--;
            }
            var use_poem_line:Boolean = false;
            if (this.line_counter == 4 || this.poem_counter > this.poem_lines.length - 10 ||
                (this.line_counter % (2+Math.floor(Math.random() * inv_poem_prob)) == 0 && this.line_counter > 4)) {
                use_poem_line = true;
            }
            if (use_poem_line) {
                var ret:String = this.poem_lines[this.poem_counter++];
                if (ret == null) {
                    return this.poem_lines[this.poem_lines.length - 1];
                }
                return ret;
            } else {
                return this.normal_lines[Math.floor(Math.random() * this.normal_lines.length)]
            }
        }

        public function get_next_poem_line():String {
            return this.poem_lines[this.poem_counter++];
        }
    }
}
