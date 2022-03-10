class Mover {
  
  PVector position, velocity, acceleration;
  float radius, maxSpeed;
  
  
  Mover() {
    this.radius = 1;
    this.position = new PVector(0,0);
    this.velocity = PVector.random2D();
    this.acceleration = new PVector(0,0);
    this.maxSpeed = 1;
  }
  
  Mover(float x, float y) {
    this();
    this.position = new PVector(x,y);
  }
  
  Mover(float x, float y, float r) {
    this(x, y);
    this.radius = r;
  }
  
  
  void applyForce(PVector force) {
    this.acceleration.add(force);
  }
  
  void update() {
    this.speedCap();
    this.velocity.add(acceleration);
    this.position.add(velocity);
    this.acceleration.mult(0);
  }
  
  void render() {
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
  
  void bounceX(float xmin, float xmax) {
    if (this.position.x - this.radius < xmin || this.position.x + this.radius > xmax) {
      this.velocity.x *= -.9;
    }
  }
  
  void bounceY(float ymin, float ymax) {
    if (this.position.y  - this.radius < ymin || this.position.y + this.radius > ymax) {
      this.velocity.y *= -.9;
    }
  }
  
  void bounceXY(float xmin, float xmax, float ymin, float ymax) {
    this.bounceX(xmin, xmax);
    this.bounceY(ymin, ymax);
  }
  
  void speedCap() {
    if (this.velocity.mag() > this.maxSpeed) {
      this.velocity.setMag(this.maxSpeed);
    }
  }
  
  boolean colliding(float x2, float y2, float r2) {
    if (dist(this.position.x, this.position.y, x2, y2) <= this.radius + r2) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean colliding(Mover mover) {
    return colliding(mover.position.x, mover.position.y, mover.radius);
  }
  
}
