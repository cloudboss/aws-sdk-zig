pub const EntityState = enum {
    enabled,
    disabled,
    deleted,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .deleted = "DELETED",
    };
};
