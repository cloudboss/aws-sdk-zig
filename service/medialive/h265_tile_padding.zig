/// H265 Tile Padding
pub const H265TilePadding = enum {
    none,
    padded,

    pub const json_field_names = .{
        .none = "NONE",
        .padded = "PADDED",
    };
};
