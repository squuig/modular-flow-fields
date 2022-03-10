class FlowField {

  int res;
  float margin, leftx, rightx, topy, boty, cols, rows;
  PVector[][] grid;

  FlowField(float r, float m) {
    this.margin = m;
    this.leftx = int(width * -margin);
    this.rightx = int(width * (1 + margin));
    this.topy = int(height * -margin);
    this.boty = int(height * (1 + margin));
    this.res = int(width * r);
    this.cols = (this.rightx - this.leftx) / this.res;
    this.rows = (this.boty - this.topy) / this.res;
    
    int tx = int(this.cols);
    int ty = int(this.rows);
    
    this.grid = new PVector[tx][ty];
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        float bx = leftx + (col * (rightx - leftx)/cols);
        float by = topy + (row * (boty - topy)/rows);
        grid[col][row] = new PVector(bx, by, 0);
      }
    }
  }

  void visualize(float cs, float ls) {
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        float bx = grid[col][row].x;
        float by = grid[col][row].y;
        PVector angle = PVector.fromAngle(grid[col][row].z).mult(ls);
        circle(bx, by, cs);
        line(bx, by, bx+angle.x, by+angle.y);
      }
    }
  }
  
  void setAngle(int col, int row, float angle) {
    this.grid[col][row].z = angle;
  }
  
  float nearestAngle(float x, float y) {
    float ax = x - leftx;
    float ay = y - topy;
    
    int col = int(ax/this.res);
    int row = int(ay/this.res);
    
    if (col < 0 || col >= cols || row < 0 || row >= rows) {
      return 0;
    }
    
    return this.grid[col][row].z;
  }
  
  float nearestAngle(PVector point) {
    return this.nearestAngle(point.x, point.y);
  }
}
