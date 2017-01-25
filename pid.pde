import java.util.*;

PVector gravity = new PVector(0, -1);
float g = .0354864; // px/(ms^2)
float max_throttle = 60 * g;
float air_resistance = .999;
PVector throttle = new PVector(0, 1);
int halfwidth;
int halfheight;
PVector setpoint;
Rocket r;
int prev_frame;

float Kp = .02;
float Ki = .3;
float Kd = 35;


void setup() {
    //frameRate(20);
    size(800, 960);
    halfwidth = width / 2;
    halfheight = height / 2;
    r = new Rocket(halfwidth, halfheight);
    strokeWeight(200);
    setpoint = new PVector(halfwidth, halfheight);
    prev_frame = millis();
}

void draw() {
    int now = millis();
    int dt = now - prev_frame;
    scale(1, -1);
    translate(0, -height);
    background(190);
    echo("fps", 1000 / dt);
    stroke(255, 0, 0, 100);
    point(setpoint.x, setpoint.y);
    r.update(dt);
    r.pid(dt);
    r.draw();
    echo("throttle", throttle.mag());
    echo("velocity", round(r.vel.y));
    echo("setpoint.y", setpoint.y);
    echo("kp", Kp);
    echo("ki", Ki);
    echo("kd", Kd);
    reset_echo_offset();
    prev_frame = now;
}

void keyPressed() {
    if (key != CODED) return;
    if (keyCode == UP) setpoint.y += 10;
    else if (keyCode == DOWN) setpoint.y -= 10;
}

void mouseClicked() {
    setpoint.y = height - mouseY;
}