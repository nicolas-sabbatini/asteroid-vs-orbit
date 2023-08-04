use bevy::prelude::*;

#[derive(SystemSet, Debug, Hash, PartialEq, Eq, Clone)]
pub enum GameSet {}

#[derive(States, Debug, Hash, PartialEq, Eq, Clone, Default)]
pub enum GameState {
    LoadAssets,
    #[default]
    RunGame,
}

#[derive(States, Debug, Hash, PartialEq, Eq, Clone, Default)]
pub enum RunState {
    #[default]
    None,
    Run,
    Pause,
}

pub struct FlowControlPlugin;
impl Plugin for FlowControlPlugin {
    fn build(&self, app: &mut App) {
        app.add_state::<GameState>().add_state::<RunState>();
    }
}
