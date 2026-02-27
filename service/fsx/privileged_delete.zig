pub const PrivilegedDelete = enum {
    disabled,
    enabled,
    permanently_disabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .permanently_disabled = "PERMANENTLY_DISABLED",
    };
};
