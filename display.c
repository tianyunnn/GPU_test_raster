#include "display.h"


static uint32_t* framebuffer = NULL;


static uint16_t window_width = 800;
static uint16_t window_height = 800;

bool create_window(void) {
 
  framebuffer = malloc(sizeof(uint32_t) * SCREEN_WIDTH * SCREEN_HEIGHT);
  if (!framebuffer) {
    fprintf(stderr, "Error allocating memory for the framebuffer.\n");
    return false;
  }

  return true;
}

void draw_pixel(uint8_t x, uint8_t y, uint32_t color) {
  if (x < 0 || x >= SCREEN_WIDTH || y < 0 || y >= SCREEN_HEIGHT) {
    return;
  }
  framebuffer[(SCREEN_WIDTH * y) + x] = color;
}



void clear_framebuffer(uint32_t color) {
  for (uint16_t i = 0; i < SCREEN_WIDTH * SCREEN_HEIGHT; i++) {
    framebuffer[i] = color;
  }
}


void destroy_window(void) {
  free(framebuffer);
}
