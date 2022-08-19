use bevy::{
    core_pipeline::clear_color::ClearColorConfig,
    prelude::*,
    render::{
        camera::{RenderTarget, ScalingMode},
        render_resource::{Extent3d, TextureDimension, TextureFormat, TextureUsages},
        view::RenderLayers,
    },
};

use crate::config::{MAIN_CLEAR_COLOR, WIN_HEIGHT, WIN_WIDTH};

const BGRA_PIXEL_SIZE: usize = 4;
const WHITE_BGRA: [u8; (WIN_WIDTH * WIN_HEIGHT) as usize * BGRA_PIXEL_SIZE] =
    [255; (WIN_WIDTH * WIN_HEIGHT) as usize * BGRA_PIXEL_SIZE];

#[derive(Debug, Component)]
pub struct GameCamera;

pub struct CameraPlugin;
impl Plugin for CameraPlugin {
    fn build(&self, app: &mut App) {
        app.add_startup_system(setup_camera);
    }
}

fn setup_camera(mut commands: Commands, mut images: ResMut<Assets<Image>>) {
    // Set up main camera
    let mut main_camera = Camera2dBundle::default();
    main_camera.projection.scaling_mode = ScalingMode::Auto {
        min_width: WIN_WIDTH,
        min_height: WIN_HEIGHT,
    };
    main_camera.camera_2d.clear_color = ClearColorConfig::Custom(MAIN_CLEAR_COLOR);
    // Draw last
    main_camera.camera.priority = 2;
    // Spawn main camera
    commands
        .spawn_bundle(main_camera)
        .insert(Name::new("Main camera"))
        // Only draw layer 1
        .insert(RenderLayers::layer(1));

    // Set up letter boxing
    // Create render target
    let render_target_size = Extent3d {
        width: WIN_WIDTH as u32,
        height: WIN_HEIGHT as u32,
        ..default()
    };

    #[cfg(not(target_arch = "wasm32"))]
    let mut render_target_image = Image::new_fill(
        render_target_size,
        TextureDimension::D2,
        &WHITE_BGRA,
        TextureFormat::Bgra8UnormSrgb,
    );

    #[cfg(target_arch = "wasm32")]
    let mut render_target_image = Image::new_fill(
        render_target_size,
        TextureDimension::D2,
        &WHITE_BGRA,
        TextureFormat::Rgba8UnormSrgb,
    );

    // By default an image can't be used as a render target
    render_target_image.texture_descriptor.usage |= TextureUsages::RENDER_ATTACHMENT;

    let render_target_handle = images.add(render_target_image);
    // Spawn render target on the world
    commands
        .spawn_bundle(SpriteBundle {
            texture: render_target_handle.clone(),
            ..Default::default()
        })
        .insert(Name::new("Render Target"))
        // Only the main camera can see the render target
        .insert(RenderLayers::layer(1));

    // Set up game camera
    let mut game_camera = Camera2dBundle::default();
    // Set up the render target created previously as target
    game_camera.camera.target = RenderTarget::Image(render_target_handle);
    // Draw before main camera
    game_camera.camera.priority = 1;
    // Spawn game camera
    commands
        .spawn_bundle(game_camera)
        .insert(Name::new("Game Camera"))
        .insert(GameCamera);
}
