pub const AccessScopeType = enum {
    cluster,
    namespace,

    pub const json_field_names = .{
        .cluster = "cluster",
        .namespace = "namespace",
    };
};
