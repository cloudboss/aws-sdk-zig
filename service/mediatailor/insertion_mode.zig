/// Insertion Mode controls whether players can use stitched or guided ad
/// insertion.
pub const InsertionMode = enum {
    stitched_only,
    player_select,

    pub const json_field_names = .{
        .stitched_only = "STITCHED_ONLY",
        .player_select = "PLAYER_SELECT",
    };
};
