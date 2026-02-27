pub const UpdateAction = enum {
    /// Add permissions.
    add,
    /// Revoke permissions.
    revoke,

    pub const json_field_names = .{
        .add = "ADD",
        .revoke = "REVOKE",
    };
};
