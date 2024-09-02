#![allow(clippy::cast_precision_loss)]
use game_loop::Game;
use globals::{HEIGHT, WIDTH};
use macroquad::prelude::*;

mod game_loop;
mod globals;

fn win_config() -> Conf {
    Conf {
        window_title: "Asteroid vs Orbit".to_string(),
        window_width: WIDTH,
        window_height: HEIGHT,
        window_resizable: true,
        ..Default::default()
    }
}

#[macroquad::main(win_config)]
async fn main() {
    let mut game = Game::new();
    while game.update() {
        game.draw();
        next_frame().await;
    }
}
