use bevy::prelude::Color;
// Screen config
pub const WINDOW_WIDTH: f32 = 800.0;
pub const WINDOW_HEIGHT: f32 = 700.0;
pub const WINDOW_TITLE: &str = "asteroid-vs-orbit";

pub const WINDOW_CAMERA_NAME: &str = "windows camera";
pub const WINDOW_CAMERA_CLEAR_COLOR: Color = Color::Rgba {
    red: 0.3,
    green: 0.3,
    blue: 0.3,
    alpha: 1.0,
};

pub const GAME_CAMERA_NAME: &str = "game camera";
pub const GAME_CAMERA_TARGET_NAME: &str = "game camera target";
pub const GAME_CAMERA_CLEAR_COLOR: Color = Color::Rgba {
    red: 0.0,
    green: 0.0,
    blue: 0.0,
    alpha: 1.0,
};
