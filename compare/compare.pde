PImage img1, img2;
void setup()
{
size(1900,1350);
img1 = loadImage("signature1.jpg");
img2 = loadImage("signature2.jpg");

loadPixels();
img1.loadPixels();
img2.loadPixels();


PImage img3 = grayscale1(img1); 
PImage img4 = grayscale2(img2); 
   
PImage img5 = threshold1(img3); 
PImage img6 = threshold2(img4);

float [][] ma = function(img5);
float [][] mb = function(img6);


float similarity = 0;
for (int a=0; a<81; a++)
  for ( int b = 0; b<8; b++){
    float sum = ma[a][b]*mb[a][b];
    
       float mul1 =  sqrt(ma[a][b]*ma[a][b]);
       //println(mul1);
          float mul2 = sqrt ( mb[a][b]*mb[a][b]);
         //  println(mul2);
     similarity = (sum / (mul1*mul2));
  }
    
 println("similarity:", similarity);
 
  image(img1,0,0);
  image(img2,0,450);
  image(img3,650,0);
  image(img4,650,450);
  image(img5,1250,0);
  image(img6,1250,450);
  }
  
  
PImage grayscale1(PImage img1)
{
  PImage img3 = createImage(img1.width, img1.height, RGB);
img3.loadPixels();
 for( int y=0; y < img1.height; y ++)
for(int x=0; x < img1.width; x ++)
{
  int imgIndex = x + y * img1.width;
  float r = red(img1.pixels[imgIndex]);
    float g = green(img1.pixels[imgIndex]);
      float b = blue(img1.pixels[imgIndex]);
     img3.pixels[ imgIndex] = color(0.21*r+ 0.72*g + 0.07*b);
 
}
img3.updatePixels();
return img3;
}


PImage grayscale2(PImage img2)
{
    PImage img4 = createImage(img2.width, img2.height, RGB);
img4.loadPixels();
 for( int y=0; y < img2.height; y ++)
for(int x=0; x < img2.width; x ++)
{
  int imgIndex = x + y * img2.width;
  float r = red(img2.pixels[imgIndex]);
    float g = green(img2.pixels[imgIndex]);
      float b = blue(img2.pixels[imgIndex]);
     img4.pixels[ imgIndex] = color(0.21*r+ 0.72*g + 0.07*b);
 
}
img4.updatePixels();
return img4;
}
  
  
  
  
 

PImage threshold1(PImage img3)
{
 float TH = 127;
  float r =0;
PImage img5 = createImage(img3.width, img3.height, RGB);
img5.loadPixels();
for (int y = 0; y< img3.height; y++){
   for ( int x = 0; x < img3.width; x++) {
     int index = x + y * img3.width;
     r = brightness(img3.pixels[index]);
   if( r <= TH)
       img5.pixels[index] = color(0);
   else 
       img5.pixels[index] = color(255);
   }
   
  ///PImage crop;
   
  ///img5.crop = get(400,100,width,height);
}
img5.updatePixels();
///image(img3,0,480);
   return img5;
}

PImage threshold2(PImage img4)
{
 float TH = 127;
  float r =0;
PImage img6 = createImage(img4.width, img4.height, RGB);
img6.loadPixels();
for (int y = 0; y< img4.height; y++){
   for ( int x = 0; x < img4.width; x++) {
     int index = x + y * img4.width;
     r = brightness(img4.pixels[index]);
   if( r <= TH)
       img6.pixels[index] = color(0);
   else 
       img6.pixels[index] = color(255);
   }
  //img6 = get(10,80,width,height);
}
img6.updatePixels();
///image(img3,0,480);
   return img6;
}

float[][] function(PImage img)
{
 
 int   gradientsvalue=0;
  float [][] m1 = new float [81][8];
 
  float e0=0,e1=0,e2=0,e3=0,e4=0,e5=0,e6=0,e7=0;
 float  gx =0,gy=0;
 float theta=0;
 float n=8; 
  
 



float[][]  filterx = { { -1,  0, 1},
                      { -2, 0, 2 },
                      { -1, 0,  1}};

float[][]  filtery = { { -1,  0, 1},
                      { -2, 0, 2 },
                      { -1, 0,  1}};
                      
for (int y = 1; y< img.height-1; y++){
   for ( int x = 1; x < img.width-1; x++) {

     gx = gy = 0;
      for (int ky = -1; ky<= 1; ky++){
     for (int kx = -1; kx<= 1; kx++)
     {
       int index = ( y+ ky)* img.width + ( x + kx);
       float r = brightness( img.pixels[index]);
     
       gx  += filterx[ ky+1][kx+1] * r;
       gy += filtery[ ky+1][kx+1] * r;
     }
      }
        gradientsvalue = color(abs(gx)+(gy));
     
               img.pixels[ y*img.width + x] = gradientsvalue;
            
               
      if (gx > 0 )
 {
 theta=atan(gy/gx);
 }
 
 
  else if (gx < 0 )
  {
  theta=atan(gy/gx)+ PI;
  }
  
  else if (gy>0)
  {
  theta= PI/2;
  }
  
  else if (gy<0)
  {
  theta=-PI/2;
  }
  else
  {
    theta = 0;
  }
  
  //println(theta);

e0=0;e1=0;e2=0;e3=0;e4=0;e5=0;e6=0;e7=0;
  if(theta >= 0 && theta < PI/4)
  {
    e0 =abs(gx)+abs(gy);
  }
  
 if(theta >= PI/4 && theta < PI/2)
  {
    e1 = abs(gx)+abs(gy); 
  }
  
  if(theta >= PI/2 && theta < 3*PI/4)
  {
    e2 = abs(gx)+abs(gy);
  }
  
  if(theta >= 3*PI/4 && theta < PI)
  {
    e3 =abs(gx)+abs(gy);
  }
  
  if(theta >= PI && theta < 5*PI/4)
  {
    e4 =abs(gx)+abs(gy);
  }
  
   if(theta >= 5*PI/4 && theta < 3*PI/2)
  {
    e5 = abs(gx)+abs(gy);
  }
  
  if(theta >= 3*PI/2 && theta < 7*PI/4)
  {
    e6 =abs(gx)+abs(gy);
  }
  
  if(theta >= 7*PI/4 && theta < 2*PI)
  {
    e7 = abs(gx)+abs(gy);
  }
  
   

    
int p = (x*9/img.width);
//println(p);
int g = (y*9/img.height);
//println(g);
int d = g *9 +p;
///println(d);


  m1[d][0] += e0;
  m1[d][1] += e1; 
  m1[d][2] += e2;
  m1[d][3] += e3;
  m1[d][4] += e4;
  m1[d][5] += e5;
  m1[d][6] += e6;
  m1[d][7] += e7;



///System.out.print(m1[d][0] );
   }
}

   return m1;
   
}

 

   
 
   



















        
 
 
 
