use bevy::{prelude::*, sprite::MaterialMesh2dBundle};

use crate::flow_control::GameState;

use super::CelestialSize;

const STAR_X: f32 = 0.0;
const STAR_Y: f32 = 0.0;
const STAR_Z: f32 = 5.0;
const STAR_SIZE: f32 = 40.0;

const RING_POS: Vec2 = Vec2::ZERO;
pub const RING_SIZE: f32 = 240.0;
const RING_SEGMENTS: usize = 256;

pub struct StarPlugin;
impl Plugin for StarPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(OnEnter(GameState::RunGame), (set_up_star, set_up_ring))
            .add_systems(Update, (draw_ring).run_if(in_state(GameState::RunGame)));
    }
}

fn set_up_star(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<ColorMaterial>>,
) {
    commands.spawn((
        MaterialMesh2dBundle {
            mesh: meshes.add(shape::Circle::new(STAR_SIZE).into()).into(),
            material: materials.add(ColorMaterial::from(Color::YELLOW)),
            transform: Transform::from_translation(Vec3::new(STAR_X, STAR_Y, STAR_Z)),
            ..default()
        },
        CelestialSize(STAR_SIZE),
        Name::new("Star"),
    ));
}

fn set_up_ring(mut config: ResMut<GizmoConfig>) {
    config.line_width = 1.0;
}

fn draw_ring(mut gizmos: Gizmos) {
    gizmos
        .circle_2d(RING_POS, RING_SIZE, Color::WHITE)
        .segments(RING_SEGMENTS);
}
