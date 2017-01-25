int text_offset = 0;

void echo(String s) {
    pushMatrix();
    scale(1, -1);
    fill(0);
    text(s, 10, 20 + 20 * text_offset - height);
    popMatrix();
    text_offset ++;
}

void echo(String s, int i) {
    echo(s + ": " + Integer.toString(i));
}

void echo(String s, float f) {
    echo(s + ": " + Float.toString(f));
}

void reset_echo_offset() {
    text_offset = 0;
}