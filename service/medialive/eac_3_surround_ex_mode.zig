/// Eac3 Surround Ex Mode
pub const Eac3SurroundExMode = enum {
    disabled,
    enabled,
    not_indicated,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .not_indicated = "NOT_INDICATED",
    };
};
