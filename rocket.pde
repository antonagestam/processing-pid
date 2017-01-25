class Rocket {
    PVector pos;
    PVector vel;
    int maxvel;
    
    Rocket (int x, int y) {
        this.pos = new PVector(x, y);
        this.vel = new PVector(0, 0);
    }
    
    void draw() {
        stroke(0, 0, 150, 150);
        point(this.pos.x, this.pos.y);
    }
    
    void update(int dt) {
        gravity.setMag(dt * g);
        this.vel.add(gravity);
        this.vel.add(throttle);
        this.vel.mult(air_resistance);
        int v = abs(round(this.vel.mag()));
        if (v > this.maxvel) this.maxvel = v;
        echo("max velocity", this.maxvel);
        this.pos.add(this.vel);
    }

    ErrorQueue errors = new ErrorQueue(100);
    
    float get_error() {
        float error = setpoint.y - this.pos.y;
        echo("error", round(error));
        this.errors.add(error);
        return error;
    }

    void pid(int dt) {
        float error = this.get_error();
        float p = Kp * error;
        float i = Ki * errors.mean() / dt;
        float d = Kd * errors.delta() / dt;
        float pid = max(-max_throttle, min(max_throttle, p + i + d));
        echo("P", p);
        echo("I", i);
        echo("D", d);
        throttle = new PVector(0, 1);
        throttle.setMag(pid);
    }
}