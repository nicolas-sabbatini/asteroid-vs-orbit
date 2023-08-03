use bevy::prelude::{IVec2, KeyCode};

const UP: IVec2 = IVec2::Y;
const DOWN: IVec2 = IVec2::NEG_Y;
const LEFT: IVec2 = IVec2::NEG_X;
const RIGHT: IVec2 = IVec2::X;

pub const DIR_KEY_MAPPING: [(KeyCode, IVec2); 4] = [
    (KeyCode::W, UP),
    (KeyCode::S, DOWN),
    (KeyCode::A, LEFT),
    (KeyCode::D, RIGHT),
];
