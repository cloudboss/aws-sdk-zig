/// Ac3 Lfe Filter
pub const Ac3LfeFilter = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
