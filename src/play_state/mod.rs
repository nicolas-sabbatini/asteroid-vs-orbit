use bevy::prelude::*;

mod game_logic;
mod game_ui;
pub mod player;
mod star;

#[derive(Debug, Component)]
struct CelestialSize(f32);

pub struct PlayStatePlugin;
impl Plugin for PlayStatePlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((
            game_logic::GameLogicStatePlugin,
            game_ui::GameUiPlugin,
            player::PlayerPlugin,
            star::StarPlugin,
        ));
    }
}
