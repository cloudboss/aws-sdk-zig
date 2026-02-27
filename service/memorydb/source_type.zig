pub const SourceType = enum {
    node,
    parameter_group,
    subnet_group,
    cluster,
    user,
    acl,

    pub const json_field_names = .{
        .node = "node",
        .parameter_group = "parameter_group",
        .subnet_group = "subnet_group",
        .cluster = "cluster",
        .user = "user",
        .acl = "acl",
    };
};
