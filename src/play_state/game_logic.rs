use bevy::prelude::*;

use crate::flow_control::RunState;

use super::{
    game_ui::UpdateScoreboardEvent,
    player::{CanScore, Player},
    CelestialSize,
};

#[derive(Debug, Resource, Default)]
pub struct Score(usize);

pub struct GameLogicStatePlugin;
impl Plugin for GameLogicStatePlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<Score>()
            .add_systems(OnEnter(RunState::Run), restart_score)
            .add_systems(OnEnter(RunState::DeadAnimation), play_dead_animation)
            .add_systems(
                Update,
                (check_if_player_scores, check_if_player_dies).run_if(in_state(RunState::Run)),
            );
    }
}

fn restart_score(mut score: ResMut<Score>, mut score_event: EventWriter<UpdateScoreboardEvent>) {
    score.0 = 0;
    score_event.send(UpdateScoreboardEvent {
        new_score: "0".to_string(),
    });
}

fn check_if_player_scores(
    mut query: Query<(&Transform, &mut CanScore), With<Player>>,
    mut score: ResMut<Score>,
    mut score_event: EventWriter<UpdateScoreboardEvent>,
) {
    for (transform, mut can_score) in &mut query {
        if transform.translation.x > 0.0 && transform.translation.y < 0.0 && can_score.0 {
            can_score.0 = false;
            score.0 += 1;
            score_event.send(UpdateScoreboardEvent {
                new_score: score.0.to_string(),
            });
        } else if transform.translation.x < 0.0 && transform.translation.y > 0.0 && !can_score.0 {
            can_score.0 = true;
        }
    }
}

fn check_if_player_dies(
    mut player_query: Query<(&Transform, &CelestialSize), With<Player>>,
    mut celestial_query: Query<(&Transform, &CelestialSize), Without<Player>>,
    mut next_state: ResMut<NextState<RunState>>,
) {
    for (player_transform, player_size) in &mut player_query {
        for (celestial_transform, celestial_size) in &mut celestial_query {
            let distance = player_transform
                .translation
                .distance(celestial_transform.translation);
            if distance < player_size.0 + celestial_size.0 {
                next_state.set(RunState::DeadAnimation);
            }
        }
    }
}

fn play_dead_animation(mut next_state: ResMut<NextState<RunState>>) {
    next_state.set(RunState::GameOver);
}
