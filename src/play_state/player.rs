use bevy::{prelude::*, sprite::MaterialMesh2dBundle};

use crate::flow_control::GameState;

use super::star::RING_SIZE;

const PLAYER_SATRT_X: f32 = 0.0;
const PLAYER_SATRT_Y: f32 = 0.0;
const PLAYER_Z: f32 = 10.0;
const PLAYER_SIZE: f32 = 10.0;
const PLAYER_ROTATION: f32 = 4.71239;
const PLAYER_ROTATION_SPEED: f32 = 2.0;
const PLAYER_UP_SPEED: f32 = 250.0;
const PLAYER_DOWN_SPEED: f32 = 100.0;
const PLAYER_START_DISTANCE: f32 = 220.0;

#[derive(Debug, Component)]
struct Player;

#[derive(Debug, Component, Reflect)]
pub struct Rotation(f32);

#[derive(Debug, Component, Reflect)]
pub struct RotationSpeed(f32);

#[derive(Debug, Component, Reflect)]
pub struct Distance(f32);

pub struct PlayerPlugin;
impl Plugin for PlayerPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(OnEnter(GameState::RunGame), set_up_player)
            .add_systems(
                Update,
                (update_player_position).run_if(in_state(GameState::RunGame)),
            )
            .add_systems(
                Update,
                (handle_input, move_player)
                    .chain()
                    .run_if(in_state(GameState::RunGame)),
            );
    }
}

fn set_up_player(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    commands.spawn((
        MaterialMesh2dBundle {
            mesh: meshes.add(shape::Circle::new(PLAYER_SIZE).into()).into(),
            material: materials.add(ColorMaterial::from(Color::GREEN)),
            transform: Transform::from_translation(Vec3::new(
                PLAYER_SATRT_X,
                PLAYER_SATRT_Y,
                PLAYER_Z,
            )),
            ..default()
        },
        Player,
        Name::new("Player"),
        Rotation(PLAYER_ROTATION),
        RotationSpeed(PLAYER_ROTATION_SPEED),
        Distance(PLAYER_START_DISTANCE),
    ));
}

fn update_player_position(mut query: Query<(&mut Transform, &Rotation, &Distance), With<Player>>) {
    for (mut transform, rotation, distance) in &mut query {
        transform.translation.x = rotation.0.cos() * distance.0;
        transform.translation.y = rotation.0.sin() * distance.0;
    }
}

fn handle_input(
    mut query: Query<&mut Distance, With<Player>>,
    time: Res<Time>,
    keyboard_input: Res<Input<KeyCode>>,
) {
    for mut distance in &mut query {
        if keyboard_input.pressed(KeyCode::Space) {
            distance.0 += PLAYER_UP_SPEED * time.delta_seconds();
        }
    }
}

fn move_player(
    mut query: Query<(&mut RotationSpeed, &mut Rotation, &mut Distance), With<Player>>,
    time: Res<Time>,
) {
    for (mut rotation_speed, mut rotation, mut distance) in &mut query {
        let new_distance = distance.0 - PLAYER_DOWN_SPEED * time.delta_seconds();
        distance.0 = f32::min(new_distance, RING_SIZE);
        rotation_speed.0 = (RING_SIZE / distance.0).powf(1.2);
        rotation.0 += rotation_speed.0 * time.delta_seconds();
    }
}
