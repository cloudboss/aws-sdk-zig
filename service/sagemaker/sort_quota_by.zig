pub const SortQuotaBy = enum {
    name,
    creation_time,
    status,
    cluster_arn,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_time = "CREATION_TIME",
        .status = "STATUS",
        .cluster_arn = "CLUSTER_ARN",
    };
};
