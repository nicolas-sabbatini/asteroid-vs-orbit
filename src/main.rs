use bevy::prelude::*;
use camera::CameraPlugin;
use config::*;

// Load and use this module on debug
#[cfg(debug_assertions)]
use debug_plugin::DebugPlugin;
use star::StarPlugin;
#[cfg(debug_assertions)]
mod debug_plugin;

mod camera;
mod config;
mod play_state;
mod star;

fn main() {
    let mut app = App::new();

    app.insert_resource(WindowDescriptor {
        width: WIN_WIDTH,
        height: WIN_HEIGHT,
        title: WIN_TITLE.to_string(),
        fit_canvas_to_parent: true,
        ..Default::default()
    })
    .insert_resource(ClearColor(Color::rgb(0.0, 0.0, 0.0)));

    app.add_plugins(DefaultPlugins);

    app.add_plugin(CameraPlugin).add_plugin(StarPlugin);

    // Add this plugins and system on debug
    #[cfg(debug_assertions)]
    app.add_plugin(DebugPlugin);

    app.run();
}
