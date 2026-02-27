pub const RowLevelPermissionPolicy = enum {
    grant_access,
    deny_access,

    pub const json_field_names = .{
        .grant_access = "GRANT_ACCESS",
        .deny_access = "DENY_ACCESS",
    };
};
