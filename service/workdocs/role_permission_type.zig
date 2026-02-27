pub const RolePermissionType = enum {
    direct,
    inherited,

    pub const json_field_names = .{
        .direct = "DIRECT",
        .inherited = "INHERITED",
    };
};
