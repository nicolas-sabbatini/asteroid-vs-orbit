use bevy::prelude::*;

use crate::{asset_loading::AssetList, flow_control::GameState};

const SCORE_X: f32 = 0.0;
const SCORE_Y: f32 = 0.0;
const SCORE_Z: f32 = 35.0;
const SCORE_SIZE: f32 = 37.0;
const FONT_DIR: &str = "FiraSans-Bold.ttf";

#[derive(Debug, Component)]
struct Score;

#[derive(Event)]
pub struct UpdateScoreboardEvent {
    pub new_score: String,
}

#[derive(Resource)]
pub struct TextFontAssets {
    pub font: Handle<Font>,
}

pub struct GameUiPlugin;
impl Plugin for GameUiPlugin {
    fn build(&self, app: &mut App) {
        app.add_event::<UpdateScoreboardEvent>()
            .add_systems(Startup, load_font)
            .add_systems(OnEnter(GameState::RunGame), set_up_scoreboard)
            .add_systems(
                Update,
                update_scoreboard.run_if(on_event::<UpdateScoreboardEvent>()),
            );
    }
}

fn load_font(
    mut commands: Commands,
    asset_server: Res<AssetServer>,
    mut asset_list: ResMut<AssetList>,
) {
    let font = asset_server.load(FONT_DIR);
    asset_list.0.push(font.clone_untyped());
    commands.insert_resource(TextFontAssets { font });
}

fn set_up_scoreboard(mut commands: Commands, asset: Res<TextFontAssets>) {
    let font = asset.font.clone();
    let text_style = TextStyle {
        font_size: SCORE_SIZE,
        color: Color::BLACK,
        font,
    };
    let text_alignment = TextAlignment::Center;
    commands.spawn((
        Text2dBundle {
            text: Text::from_section("0", text_style.clone()).with_alignment(text_alignment),
            transform: Transform::from_translation(Vec3::new(SCORE_X, SCORE_Y, SCORE_Z)),
            ..default()
        },
        Score,
    ));
}

fn update_scoreboard(
    mut query: Query<&mut Text, With<Score>>,
    mut events: EventReader<UpdateScoreboardEvent>,
) {
    let event = events.iter().last().unwrap();
    for mut text in query.iter_mut() {
        text.sections[0].value = event.new_score.clone();
    }
}
