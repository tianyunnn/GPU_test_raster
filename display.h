#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 128

#define FPS 30
#define MILLISECS_PER_FRAME (1000 / FPS)

bool create_window(void);
void destroy_window(void);


void clear_framebuffer(uint32_t color);

void draw_pixel(uint8_t x, uint8_t y, uint32_t color);

