use bevy::diagnostic::{FrameTimeDiagnosticsPlugin, LogDiagnosticsPlugin};
use bevy::prelude::*;
use bevy_inspector_egui::quick::WorldInspectorPlugin;

use crate::play_state::player::{Distance, Rotation};

pub struct DebugPlugin;
impl Plugin for DebugPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins(WorldInspectorPlugin::default());
        app.add_plugins(LogDiagnosticsPlugin::default());
        app.add_plugins(FrameTimeDiagnosticsPlugin);
        app.register_type::<Rotation>().register_type::<Distance>();
    }
}
