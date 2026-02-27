/// Set to "padded" to force MediaConvert to add padding to the frame, to obtain
/// a frame that is a whole multiple of the tile size. If you are setting up the
/// picture as a tile, you must enter "padded". In all other configurations, you
/// typically enter "none".
pub const H265TilePadding = enum {
    none,
    padded,

    pub const json_field_names = .{
        .none = "NONE",
        .padded = "PADDED",
    };
};
