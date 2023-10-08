// // Load and use this module on debug
#[cfg(debug_assertions)]
use debug_plugin::DebugPlugin;
#[cfg(debug_assertions)]
mod debug_plugin;

use asset_loading::AssetLoadingPlugin;
use bevy::{prelude::*, window::WindowResolution};
use camera::CameraPlugin;
use config::*;
use flow_control::FlowControlPlugin;
use game_over_state::GameOverStatePlugin;
use main_menu_state::MainMenuStatePlugin;
use play_state::PlayStatePlugin;

mod asset_loading;
mod camera;
mod config;
mod flow_control;
mod game_over_state;
mod main_menu_state;
mod play_state;

fn main() {
    let mut app = App::new();

    app.add_plugins(DefaultPlugins.set(WindowPlugin {
        primary_window: Some(Window {
            resolution: WindowResolution::new(WINDOW_WIDTH, WINDOW_HEIGHT),
            title: WINDOW_TITLE.to_string(),
            fit_canvas_to_parent: true,
            ..default()
        }),
        ..default()
    }))
    .insert_resource(Msaa::Off);

    #[cfg(debug_assertions)]
    app.add_plugins(DebugPlugin);

    app.add_plugins((CameraPlugin, FlowControlPlugin, AssetLoadingPlugin));

    app.add_plugins((MainMenuStatePlugin, PlayStatePlugin, GameOverStatePlugin));

    // When the assets finish loading, change the state to the main menu
    app.add_systems(
        OnEnter(flow_control::GameState::RunGame),
        |mut next_state: ResMut<NextState<flow_control::RunState>>| {
            next_state.set(flow_control::RunState::MainMenu);
        },
    );

    app.run();
}
