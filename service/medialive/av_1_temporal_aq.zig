/// Av1 Temporal Aq
pub const Av1TemporalAq = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
