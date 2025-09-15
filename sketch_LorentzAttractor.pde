import peasy.*; // Importing PeasyCam library

// Lorenz attractor parameters
float x = 0.01, y = 0, z = 0;
float a = 10, b = 28, c = 8.0 / 3.0;

// List to store points efficiently
ArrayList<PVector> points = new ArrayList<PVector>();
final int MAX_POINTS = 2000;

PeasyCam cam; // Camera for interaction

void setup() {
    size(800, 600, P3D);
    cam = new PeasyCam(this, 500);
    colorMode(HSB, 255);
    background(0);
}

void draw() {
    // Draw translucent rectangle to create trail effect
    fill(0, 20);
    noStroke();
    rect(0, 0, width, height);

    // Update the system
    updateLorenz();

    // Prepare view
    translate(width / 2, height / 2, -80);
    scale(5);

    // Draw the attractor
    drawAttractor();
}

// Updates the Lorenz system and adds new point
void updateLorenz() {
    float dt = 0.01;
    float dx = a * (y - x) * dt;
    float dy = (x * (b - z) - y) * dt;
    float dz = (x * y - c * z) * dt;

    x += dx;
    y += dy;
    z += dz;

    points.add(new PVector(x, y, z));

    // Keep only the latest MAX_POINTS points
    if (points.size() > MAX_POINTS) {
        points.remove(0);
    }
}

// Draws the attractor with smooth coloring
void drawAttractor() {
    noFill();
    beginShape();
    for (int i = 0; i < points.size(); i++) {
        PVector p = points.get(i);
        float hue = map(i, 0, points.size(), 0, 255);
        stroke(hue, 255, 255);
        vertex(p.x, p.y, p.z);
    }
    endShape();
}
