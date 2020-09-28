color bgColor = color(0, 0, 0);

byte sqrAmount = 10;

float sqrColorHue;
float sqrColorHueSpeed = 1;
float sqrColorHueCounter;

float sqrSize;
float sqrSizeReduction;
byte sqrSizeReductionAmount = 100;

float noiseDelay = 0.1;
float noiseSpeed = 0.1;
float noiseX;
float noiseValue;

void setup() {
  size(1280, 720);
 
  frameRate(144);

  //Jeg har gjort vinduet resizable.
  surface.setResizable(true);
  
  colorMode(HSB);
}

void draw() {  
  background(bgColor);

  noiseX += noiseSpeed/10;
  sqrColorHueCounter += sqrColorHueSpeed/10;
  
  DrawSquare();
}

void DrawSquare() {
  for(int i = 0;  i < sqrAmount; i++) {
    for(int j = 0; j < sqrAmount; j++) {
      
      //Jeg bruger Perlin Noise til at generere tilfældige tal, så jeg kan lave en slags bølgeeffekt.
      noiseValue = noise(noiseX + (i + j) * noiseDelay);
      
      sqrSize = width / 2 / (sqrAmount);
      sqrSizeReduction = sqrSize * (sqrSizeReductionAmount * noiseValue) / 100;
      
      fill(SqrColorHue(noiseValue), 255, 255);
      //Tegner firkanterne i forhold til vinduets størrelse.
      square(
        (width / 4 + i * (sqrSize)) + sqrSizeReduction / 2,
        (height / 2 - width/4 + j * sqrSize) + sqrSizeReduction / 2,
        sqrSize - sqrSizeReduction
      );
    }
  }
}

//Sætter hue-værdien til at følge Perlin-noisen, men da Perlin Noise sjældent rammer 0 og 1, har jeg fået den til at lægge en offset til over tid, som resetter, når den rammer 255.
float SqrColorHue(float rnd) {
  
  sqrColorHue = rnd * 255;
  
  if(sqrColorHueCounter > 255)
    sqrColorHueCounter -= 256;
  
  sqrColorHue += sqrColorHueCounter;
  
  if(sqrColorHue > 255)
    return sqrColorHue - 256;
  
  return sqrColorHue;
}

//Man kan ændre antallet af firkanter med musseklik.
void mouseClicked() {
    
    sqrAmount++;
    
    if(sqrAmount > 10)
      sqrAmount = 1;
}
