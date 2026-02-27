pub const SourceType = enum {
    cluster,
    parameter_group,
    subnet_group,

    pub const json_field_names = .{
        .cluster = "CLUSTER",
        .parameter_group = "PARAMETER_GROUP",
        .subnet_group = "SUBNET_GROUP",
    };
};
