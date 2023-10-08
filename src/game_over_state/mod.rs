use bevy::prelude::*;

use crate::flow_control::RunState;

pub struct GameOverStatePlugin;
impl Plugin for GameOverStatePlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(OnEnter(RunState::GameOver), change_state);
    }
}

fn change_state(mut next_state: ResMut<NextState<RunState>>) {
    next_state.set(RunState::Run);
}
