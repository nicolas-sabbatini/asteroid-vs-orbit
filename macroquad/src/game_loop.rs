use macroquad::prelude::*;
use macroquad_canvas_2d::Canvas2D;

use crate::globals::{HEIGHT, WIDTH};

pub struct Game {
    screen: Canvas2D,
}

impl Game {
    pub fn new() -> Self {
        let canvas = Canvas2D::new(WIDTH as f32, HEIGHT as f32);
        // canvas.get_texture_mut().set_filter(FilterMode::Nearest);

        Game { screen: canvas }
    }

    pub fn update(&mut self) -> bool {
        true
    }

    pub fn draw(&self) {
        // Draw inside canvas
        self.screen.set_camera();
        {
            // Clear background
            clear_background(WHITE);
            // Draw something
            // Top left
            draw_rectangle(0.0, 0.0, 60.0, 60.0, RED);
            // Top right
            draw_rectangle(WIDTH as f32 - 60.0, 0.0, 60.0, 60.0, GRAY);
            // Bottom left
            draw_rectangle(0.0, HEIGHT as f32 - 60.0, 60.0, 60.0, GREEN);
            // Bottom right
            draw_rectangle(WIDTH as f32 - 60.0, HEIGHT as f32 - 60.0, 60.0, 60.0, BLUE);
        }
        set_default_camera();

        clear_background(BLACK);
        self.screen.draw_to_screen();
    }
}
