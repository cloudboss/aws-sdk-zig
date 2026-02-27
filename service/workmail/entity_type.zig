pub const EntityType = enum {
    group,
    user,
    resource,

    pub const json_field_names = .{
        .group = "GROUP",
        .user = "USER",
        .resource = "RESOURCE",
    };
};
