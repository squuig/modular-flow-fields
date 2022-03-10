FlowField field; //<>//
Mover mover;
Curve curve;
ArrayList<Curve> curves;

void setup() {
  size(1000, 1000);
  stroke(255);

  field = new FlowField(0.001, 0.5);
  for (int col = 0; col < field.cols; col++) {
    for (int row = 0; row < field.rows; row++) {
      float ang = map(noise(col * .005, row * .005), -1, 1, 0, TWO_PI);
      field.setAngle(col, row, ang);
    }
  }
}

void draw() {
  noLoop();
  strokeWeight(1);
  curveTightness(0);

  curves = new ArrayList<Curve>();

  for (int i = 0; i < 10000; i++) {
    curves.add(new Curve(new PVector(random(width), random(height))));
  }

  for (Curve curve : curves) {
    for (int i = 0; i < 100; i++) {
      curve.step(1, field.nearestAngle(curve.current.x, curve.current.y));
    }
  }

  background(0);

  noFill();
  //strokeWeight(.2);
  //field.visualize(1, 15);

  stroke(255);
  strokeWeight(.1);
  for (Curve curve : curves) {
    curve.drawCurve();
  }
  //fill(255);
  //PVector force = PVector.fromAngle(field.nearestAngle(mover.position.x, mover.position.y));
  //mover.applyForce(force.mult(.1));
  //mover.update();
  //mover.render();
}

void keyPressed() {
  if (key == '`') {
    String name = getClass().getSimpleName();
    String t = str(year())+str(month())+str(day())+str(hour())+str(minute())+str(second());
    String imgfiletype = ".png";
    saveFrame("C:\\Users\\savic\\Documents\\Processing\\images\\" + name + t + imgfiletype);
  }
}
