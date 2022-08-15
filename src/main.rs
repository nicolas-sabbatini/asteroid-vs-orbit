use bevy::{prelude::*, sprite::MaterialMesh2dBundle};
use camera::CameraPlugin;
use config::*;

// Load and use this module on debug
#[cfg(debug_assertions)]
use debug_plugin::DebugPlugin;
#[cfg(debug_assertions)]
mod debug_plugin;

mod camera;
mod config;

fn main() {
    let mut app = App::new();

    app.insert_resource(WindowDescriptor {
        width: WIN_WIDTH,
        height: WIN_HEIGHT,
        title: WIN_TITLE.to_string(),
        ..Default::default()
    })
    .insert_resource(ClearColor(Color::rgb(0.0, 0.0, 0.0)));

    app.add_plugins(DefaultPlugins);

    app.add_plugin(CameraPlugin);

    // Add this plugins and system on debug
    #[cfg(debug_assertions)]
    app.add_plugin(DebugPlugin).add_startup_system(cosas);

    app.run();
}

fn cosas(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    commands.spawn_bundle(MaterialMesh2dBundle {
        mesh: meshes.add(shape::Circle::new(40.).into()).into(),
        material: materials.add(ColorMaterial::from(Color::PURPLE)),
        transform: Transform::from_translation(Vec3::new(0., 0., 10.)),
        ..default()
    });
}
