/// If you are setting up the picture as a tile, you must set this to
/// "disabled". In other configurations, you typically enter "enabled".
pub const H265MvTemporalPredictor = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
