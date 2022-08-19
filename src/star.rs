use bevy::{prelude::*, sprite::MaterialMesh2dBundle};

pub struct StarPlugin;
impl Plugin for StarPlugin {
    fn build(&self, app: &mut App) {
        app.add_startup_system(setup_star);
    }
}

fn setup_star(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    commands.spawn_bundle(MaterialMesh2dBundle {
        mesh: meshes.add(shape::Circle::new(40.).into()).into(),
        material: materials.add(ColorMaterial::from(Color::rgb(1.0, 1.0, 0.0))),
        transform: Transform::from_translation(Vec3::new(0., 0., 10.)),
        ..default()
    });
}
