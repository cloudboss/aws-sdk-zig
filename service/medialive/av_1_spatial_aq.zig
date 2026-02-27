/// Av1 Spatial Aq
pub const Av1SpatialAq = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
