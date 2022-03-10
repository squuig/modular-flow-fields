class Curve {

  int steps;
  PVector start, current;
  ArrayList<PVector> points = new ArrayList<PVector>();

  Curve(PVector start) {
    this.start = start;
    this.current = start;
    this.points.add(new PVector(current.x, current.y));
    this.steps = 50;
  }

  void step(float stepLength, float angle) {
    PVector nextStep = PVector.fromAngle(angle);
    nextStep.mult(stepLength);
    current.add(nextStep);
    points.add(new PVector(current.x, current.y));
  }

  void drawCurve() {
    beginShape();
    for (PVector p : this.points) {
      curveVertex(p.x, p.y);
    }
    endShape();
  }
}
