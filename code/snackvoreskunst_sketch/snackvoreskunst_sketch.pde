// Martin Dybdal (dybber@dybber.dk) 2016

// Written April 8-10th 2016 at the Danish Arts Foundations,
// Art hackathon "Hack Vores Kunst"

import processing.pdf.*;

// The following font code is based on
//  https://trmm.net/Asteroids_font
//  https://github.com/osresearch/vst/blob/master/teensyv/asteroids_font.c

static int FONT_UP = 0xFE;
static int FONT_LAST = 0xFF;

int P(int x, int y) {
  return ((x & 0xF) << 4) | (y & 0xF);
}

int[][] asteroids_font = {
  {},                                                                     /* space */
	{ P(4,0), P(3,2), P(5,2), P(4,0), FONT_UP, P(4,4), P(4,12) },           /* ! */
	{ P(2,10), P(2,6), FONT_UP, P(6,10), P(6,6) },                          /* " */
	{ P(0,4), P(8,4), P(6,2), P(6,10), P(8,8), P(0,8), P(2,10), P(2,2) },   /* # */
	{ P(6,2), P(2,6), P(6,10), FONT_UP, P(4,12), P(4,0) },                  /* $ */
	{ P(0,0), P(8,12), FONT_UP, P(2,10), P(2,8), FONT_UP, P(6,4), P(6,2) }, /* % */
	{ P(8,0), P(4,12), P(8,8), P(0,4), P(4,0), P(8,4) },                    /* & */
	{ P(2,6), P(6,10) },                                                    /* ' */
	{ P(6,0), P(2,4), P(2,8), P(6,12) },                                    /* ( */
	{ P(2,0), P(6,4), P(6,8), P(2,12) },                                    /* ) */
	{ P(0,0), P(4,12), P(8,0), P(0,8), P(8,8), P(0,0) },                    /* * */
	{ P(1,6), P(7,6), FONT_UP, P(4,9), P(4,3) },                            /* + */
	{ P(2,0), P(4,2) },                                                     /* , */
	{ P(2,6), P(6,6) },                                                     /* - */
	{ P(3,0), P(4,0) },                                                     /* . */
	{ P(0,0), P(8,12) },                                                    /* / */
	{ P(0,0), P(8,0), P(8,12), P(0,12), P(0,0), P(8,12) },                  /* 0 */
	{ P(4,0), P(4,12), P(3,10) },                                           /* 1 */
	{ P(0,12), P(8,12), P(8,7), P(0,5), P(0,0), P(8,0) },                   /* 2 */
	{ P(0,12), P(8,12), P(8,0), P(0,0), FONT_UP, P(0,6), P(8,6) },          /* 3 */
	{ P(0,12), P(0,6), P(8,6), FONT_UP, P(8,12), P(8,0) },                  /* 4 */
	{ P(0,0), P(8,0), P(8,6), P(0,7), P(0,12), P(8,12) },                   /* 5 */
	{ P(0,12), P(0,0), P(8,0), P(8,5), P(0,7) },                            /* 6 */
	{ P(0,12), P(8,12), P(8,6), P(4,0) },                                   /* 7 */
	{ P(0,0), P(8,0), P(8,12), P(0,12), P(0,0), FONT_UP, P(0,6), P(8,6), }, /* 8 */
	{ P(8,0), P(8,12), P(0,12), P(0,7), P(8,5) },                           /* 9 */
	{ P(4,9), P(4,7), FONT_UP, P(4,5), P(4,3) },                            /* : */
	{ P(4,9), P(4,7), FONT_UP, P(4,5), P(1,2) },                            /* ; */
	{ P(6,0), P(2,6), P(6,12) },                                            /* < */
	{ P(1,4), P(7,4), FONT_UP, P(1,8), P(7,8) },                            /* = */
	{ P(2,0), P(6,6), P(2,12) },                                            /* > */
	{ P(0,8), P(4,12), P(8,8), P(4,4), FONT_UP, P(4,1), P(4,0) },           /* ? */
  { P(8,4), P(4,0), P(0,4), P(0,8), P(4,12), P(8,8), P(4,4), P(3,6) },    /* @ */
	{ P(0,0), P(0,8), P(4,12), P(8,8), P(8,0), FONT_UP, P(0,4), P(8,4) },   /* A */
	{ P(0,0), P(0,12), P(4,12), P(8,10), P(4,6), P(8,2), P(4,0), P(0,0) },  /* B */
	{ P(8,0), P(0,0), P(0,12), P(8,12) },                                   /* C */
	{ P(0,0), P(0,12), P(4,12), P(8,8), P(8,4), P(4,0), P(0,0) },           /* D */
	{ P(8,0), P(0,0), P(0,12), P(8,12), FONT_UP, P(0,6), P(6,6) },          /* E */
	{ P(0,0), P(0,12), P(8,12), FONT_UP, P(0,6), P(6,6) },                  /* F */
	{ P(6,6), P(8,4), P(8,0), P(0,0), P(0,12), P(8,12) },                   /* G */
	{ P(0,0), P(0,12), FONT_UP, P(0,6), P(8,6), FONT_UP, P(8,12), P(8,0) }, /* H */
	{ P(0,0), P(8,0), FONT_UP, P(4,0), P(4,12), FONT_UP, P(0,12), P(8,12) },/* I */
	{ P(0,4), P(4,0), P(8,0), P(8,12) },                                    /* J */
	{ P(0,0), P(0,12), FONT_UP, P(8,12), P(0,6), P(6,0) },                  /* K */
	{ P(8,0), P(0,0), P(0,12) },                                            /* L */
	{ P(0,0), P(0,12), P(4,8), P(8,12), P(8,0) },                           /* M */
	{ P(0,0), P(0,12), P(8,0), P(8,12) },                                   /* N */
	{ P(0,0), P(0,12), P(8,12), P(8,0), P(0,0) },                           /* O */
	{ P(0,0), P(0,12), P(8,12), P(8,6), P(0,5) },                           /* P */
	{ P(0,0), P(0,12), P(8,12), P(8,4), P(0,0), FONT_UP, P(4,4), P(8,0) },  /* Q */
	{ P(0,0), P(0,12), P(8,12), P(8,6), P(0,5), FONT_UP, P(4,5), P(8,0) },  /* R */
	{ P(0,2), P(2,0), P(8,0), P(8,5), P(0,7), P(0,12), P(6,12), P(8,10) },  /* S */
	{ P(0,12), P(8,12), FONT_UP, P(4,12), P(4,0) },                         /* T */
	{ P(0,12), P(0,2), P(4,0), P(8,2), P(8,12) },                           /* U */
	{ P(0,12), P(4,0), P(8,12) },                                           /* V */
	{ P(0,12), P(2,0), P(4,4), P(6,0), P(8,12) },                           /* W */
	{ P(0,0), P(8,12), FONT_UP, P(0,12), P(8,0) },                          /* X */
	{ P(0,12), P(4,6), P(8,12), FONT_UP, P(4,6), P(4,0) },                  /* Y */
	{ P(0,12), P(8,12), P(0,0), P(8,0), FONT_UP, P(2,6), P(6,6) },          /* Z */
	{ P(6,0), P(2,0), P(2,12), P(6,12) },                                   /* [ */
	{ P(0,12), P(8,0) },                                                    /* \ */
	{ P(2,0), P(6,0), P(6,12), P(2,12) },                                   /* ] */
	{ P(2,6), P(4,12), P(6,6) },                                            /* ^ */
	{ P(0,0), P(8,0) },                                                     /* _ */
	{ P(2,10), P(6,6) },                                                    /* ` */
	{ P(0,0), P(0,8), P(4,12), P(8,8), P(8,0), FONT_UP, P(0,4), P(8,4) },   /* A */
	{ P(0,0), P(0,12), P(4,12), P(8,10), P(4,6), P(8,2), P(4,0), P(0,0) },  /* B */
	{ P(8,0), P(0,0), P(0,12), P(8,12) },                                   /* C */
	{ P(0,0), P(0,12), P(4,12), P(8,8), P(8,4), P(4,0), P(0,0) },           /* D */
	{ P(8,0), P(0,0), P(0,12), P(8,12), FONT_UP, P(0,6), P(6,6) },          /* E */
	{ P(0,0), P(0,12), P(8,12), FONT_UP, P(0,6), P(6,6) },                  /* F */
	{ P(6,6), P(8,4), P(8,0), P(0,0), P(0,12), P(8,12) },                   /* G */
	{ P(0,0), P(0,12), FONT_UP, P(0,6), P(8,6), FONT_UP, P(8,12), P(8,0) }, /* H */
	{ P(0,0), P(8,0), FONT_UP, P(4,0), P(4,12), FONT_UP, P(0,12), P(8,12) },/* I */
	{ P(0,4), P(4,0), P(8,0), P(8,12) },                                    /* J */
	{ P(0,0), P(0,12), FONT_UP, P(8,12), P(0,6), P(6,0) },                  /* K */
	{ P(8,0), P(0,0), P(0,12) },                                            /* L */
	{ P(0,0), P(0,12), P(4,8), P(8,12), P(8,0) },                           /* M */
	{ P(0,0), P(0,12), P(8,0), P(8,12) },                                   /* N */
	{ P(0,0), P(0,12), P(8,12), P(8,0), P(0,0) },                           /* O */
	{ P(0,0), P(0,12), P(8,12), P(8,6), P(0,5) },                           /* P */
	{ P(0,0), P(0,12), P(8,12), P(8,4), P(0,0), FONT_UP, P(4,4), P(8,0) },  /* Q */
	{ P(0,0), P(0,12), P(8,12), P(8,6), P(0,5), FONT_UP, P(4,5), P(8,0) },  /* R */
	{ P(0,2), P(2,0), P(8,0), P(8,5), P(0,7), P(0,12), P(6,12), P(8,10) },  /* S */
	{ P(0,12), P(8,12), FONT_UP, P(4,12), P(4,0) },                         /* T */
	{ P(0,12), P(0,2), P(4,0), P(8,2), P(8,12) },                           /* U */
	{ P(0,12), P(4,0), P(8,12) },                                           /* V */
	{ P(0,12), P(2,0), P(4,4), P(6,0), P(8,12) },                           /* W */
	{ P(0,0), P(8,12), FONT_UP, P(0,12), P(8,0) },                          /* X */
	{ P(0,12), P(4,6), P(8,12), FONT_UP, P(4,6), P(4,0) },                  /* Y */
	{ P(0,12), P(8,12), P(0,0), P(8,0), FONT_UP, P(2,6), P(6,6) },          /* Z */
	{ P(6,0), P(4,2), P(4,10), P(6,12), FONT_UP, P(2,6), P(4,6) },          /* { */
	{ P(4,0), P(4,5), FONT_UP, P(4,6), P(4,12) },                           /* | */
	{ P(4,0), P(6,2), P(6,10), P(4,12), FONT_UP, P(6,6), P(8,6) },          /* } */
	{ P(0,4), P(2,8), P(6,4), P(8,8) }                                      /* ~ */
};

// There might still be some problems in the GCode output
// from this function, we didn't get time to debug it 
// properly doing the "Hack Vores Kunst" event
void drawGlyph(int[] glyph, int locX, int locY, int size) {
	boolean next_moveto = true;

  int x = 0;
  int y = 0;

	for(int i = 0 ; i < glyph.length ; i++) {
		int delta = glyph[i];
		if (delta == FONT_UP) {
			next_moveto = true;
			continue;
		}

		int dx = ((delta >> 4) & 0xF) * size;
		int dy = ((delta >> 0) & 0xF) * size;

    float xout = map(locX + dx, 0, width, 0, 74);
    float yout = map(locY - dy, 0, height, 0, 105);
		if (next_moveto) {
      output.println("M03 S50");
      output.println("G1 X" + xout + " Y" + yout + " F4000");
      output.println("M03 S0");
    } else {
      output.println("G1 X" + xout + " Y" + yout + " F4000");
			line(locX + x, locY - y, locX + dx, locY - dy);
    }

    x = dx;
    y = dy;
    next_moveto = false;
	}
}

/* Test text drawing */
/* drawText(10, 30, 2, "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"); */
/* drawText(10, 60, 2, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"); */
/* drawText(10, 90, 2, "0123456789"); */
void drawText(int locX, int locY, int size, String txt) {
  txt = txt.toUpperCase();
  txt = txt.replaceAll("[Ææ]", "AE");
  txt = txt.replaceAll("[Øø]", "OE");
  txt = txt.replaceAll("[Åå]", "AA");
  for(int i = 0; i < txt.length(); i++) {
    int glyphID = txt.charAt(i)-' ';

    drawGlyph(asteroids_font[glyphID], (int)(locX + i * 12 * size), locY, size);
  }
}

void drawMetadata(PImage img, int size, int id) {
  Table table = loadTable("../data/daa_emuseum_output_05.04.2016_utf8.csv", "header");

  for (TableRow row : table.rows()) {
    int objId = row.getInt("OBJECT_ID");
    if (objId == id) {
      String title = row.getString("TITLE");
      String artist = row.getString("ARTIST");
      String date = row.getString("DATE");
      String classification = row.getString("CLASSIFICATION");
      String dim = row.getString("DIMENSIONS");
      println(artist + " - " + title + " - " + date);
      println(classification + ", " + dim);

      drawText(10,img.height*10 + 40, size, artist);
      drawText(img.width*10-60,img.height*10 + 40, size, date);
      drawText(10,img.height*10 + 60, size, title);
      if(dim.equals("NULL")) {
        drawText(10,img.height*10 + 80, size, classification);
      } else {
        drawText(10,img.height*10 + 80, size, classification + ", " + dim);
      }
      drawText(img.width*5-70,img.height*10 + 110, size, "vores.kunst.dk");

      break;
    }
  }
}

// Following function is based on P_4_3_1_01.pde from:
//
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
void drawLineImage(PImage img, int id) {
  float xFactor = 0.6; //map(mouseX, 0, width, 0.05, 1);
  float yFactor = 0.5; //map(mouseY, 0, height, 0.05, 1);

  float tileWidth = width / (float)img.width;
  float tileHeight = (height - 120) / (float)img.height;

  for (int gridY = 0; gridY < img.height; gridY++) {
    float posY = tileHeight*gridY;
    output.println("M03 S50");
    float yReset = map(posY, 0, height, 0, 105);
    output.println("G1 X0 Y" + yReset + " F4000");
    output.println("M03 S0");
    for (int gridX = 0; gridX < img.width; gridX++) {
      float posX = tileWidth*gridX;

      // get pixel and neighbour pixel
      color c = img.pixels[gridY*img.width+gridX];
      int greyscale =round(red(c)*0.222+green(c)*0.707+blue(c)*0.071);
      color c2 = img.get(min(gridX+1,img.width-1), gridY);
      int greyscale2 = int(red(c2)*0.222 + green(c2)*0.707 + blue(c2)*0.071);

      float h5 = 50 * xFactor;
      float d1 = map(greyscale, 0, 255, h5, 0);
      float d2 = map(greyscale2, 0,255, h5,0);
      line(posX-d1, posY+d1, posX+tileWidth-d2, posY+d2);
      float x = map(posX-d1, 0, width, 0, 74);
      float y = map(posY+d1, 0, height, 0, 105);
      output.println("G1 X" + x + " Y" + y + " F4000");
    }
  }
}

PrintWriter output;
int fontSize = 1;

void setup() {
  int id = parseInt(args[0]);
  String imgfile = nf(id, 5) + ".jpg";
  String gcodefile = "gen/" + nf(id, 5) + ".gcode";
  String pdffile = "gen/" + nf(id, 5) + ".pdf";

  println("Reading: " + imgfile);
  PImage img = loadImage("../data/thumbs/" + imgfile);

  smooth();
  background(255);
  stroke(70);
  size(img.width*10, img.height*10 + 120);

  println("Saving GCode to: " + gcodefile);
  println("Saving PDF to: " + pdffile);

  output = createWriter(gcodefile);
  beginRecord(PDF, pdffile);
    drawLineImage(img, id);
    drawMetadata(img, fontSize, id);
  endRecord();
  output.flush();
  output.close();
}
