use bevy::prelude::*;

#[derive(SystemSet, Debug, Hash, PartialEq, Eq, Clone)]
pub enum GameSet {}

#[derive(States, Debug, Hash, PartialEq, Eq, Clone, Default)]
pub enum GameState {
    #[default]
    LoadAssets,
    RunGame,
}

#[derive(States, Debug, Hash, PartialEq, Eq, Clone, Default)]
pub enum PlayState {
    #[default]
    None,
}

pub struct FlowControlPlugin;
impl Plugin for FlowControlPlugin {
    fn build(&self, app: &mut App) {
        app.add_state::<GameState>().add_state::<PlayState>();
    }
}
