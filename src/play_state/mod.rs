use bevy::prelude::*;

use self::{player::PlayerPlugin, star::StarPlugin};

pub mod player;
mod star;

pub struct PlayStatePlugin;
impl Plugin for PlayStatePlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((StarPlugin, PlayerPlugin));
    }
}
