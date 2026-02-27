/// Temporal Filter Post Filter Sharpening
pub const TemporalFilterPostFilterSharpening = enum {
    auto,
    disabled,
    enabled,

    pub const json_field_names = .{
        .auto = "AUTO",
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
