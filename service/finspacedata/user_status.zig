pub const UserStatus = enum {
    creating,
    enabled,
    disabled,

    pub const json_field_names = .{
        .creating = "CREATING",
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
