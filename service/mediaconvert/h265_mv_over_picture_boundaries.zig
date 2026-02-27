/// If you are setting up the picture as a tile, you must set this to
/// "disabled". In all other configurations, you typically enter "enabled".
pub const H265MvOverPictureBoundaries = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
