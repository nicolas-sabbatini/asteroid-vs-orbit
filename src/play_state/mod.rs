use bevy::prelude::*;

use self::star::StarPlugin;

mod star;

pub struct PlayStatePlugin;
impl Plugin for PlayStatePlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((StarPlugin));
    }
}
