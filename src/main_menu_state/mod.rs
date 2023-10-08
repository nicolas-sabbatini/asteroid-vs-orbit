use bevy::prelude::*;

use crate::flow_control::{GameState, RunState};

pub struct MainMenuStatePlugin;
impl Plugin for MainMenuStatePlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(OnEnter(GameState::RunGame), change_state);
    }
}

fn change_state(mut next_state: ResMut<NextState<RunState>>) {
    next_state.set(RunState::Run);
}
