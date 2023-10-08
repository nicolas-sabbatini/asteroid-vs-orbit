use bevy::prelude::*;

#[derive(States, Debug, Hash, PartialEq, Eq, Clone, Default)]
pub enum GameState {
    #[default]
    LoadAssets,
    RunGame,
}

#[derive(States, Debug, Hash, PartialEq, Eq, Clone, Default)]
pub enum RunState {
    #[default]
    None,
    MinMenu,
    Run,
    DeadAnimation,
    Pause,
    GameOver,
}

pub struct FlowControlPlugin;
impl Plugin for FlowControlPlugin {
    fn build(&self, app: &mut App) {
        app.add_state::<GameState>().add_state::<RunState>();
    }
}
