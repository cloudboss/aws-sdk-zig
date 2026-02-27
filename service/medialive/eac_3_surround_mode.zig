/// Eac3 Surround Mode
pub const Eac3SurroundMode = enum {
    disabled,
    enabled,
    not_indicated,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .not_indicated = "NOT_INDICATED",
    };
};
