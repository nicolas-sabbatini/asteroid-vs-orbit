// https://github.com/maciekglowka/hike_deck/blob/main/src/assets.rs
use bevy::asset::LoadState;
use bevy::prelude::*;

use crate::flow_control::GameState;

pub struct AssetLoadingPlugin;
impl Plugin for AssetLoadingPlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<AssetList>().add_systems(
            Update,
            (check_asset_loading).run_if(in_state(GameState::LoadAssets)),
        );
    }
}

#[derive(Default, Resource)]
pub struct AssetList(pub Vec<HandleUntyped>);

pub fn check_asset_loading(
    asset_server: Res<AssetServer>,
    asset_list: Res<AssetList>,
    mut next_state: ResMut<NextState<GameState>>,
) {
    println!("check_asset_loading");
    match asset_server.get_group_load_state(asset_list.0.iter().map(|a| a.id())) {
        LoadState::Loaded => {
            next_state.set(GameState::RunGame);
        }
        LoadState::Failed => {
            error!("asset loading error");
        }
        _ => {}
    };
}
