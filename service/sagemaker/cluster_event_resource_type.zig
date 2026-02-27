pub const ClusterEventResourceType = enum {
    cluster,
    instance_group,
    instance,

    pub const json_field_names = .{
        .cluster = "CLUSTER",
        .instance_group = "INSTANCE_GROUP",
        .instance = "INSTANCE",
    };
};
