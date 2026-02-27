/// Eac3 Dc Filter
pub const Eac3DcFilter = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
