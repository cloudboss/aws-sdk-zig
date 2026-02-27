pub const ClusterSortBy = enum {
    creation_time,
    name,

    pub const json_field_names = .{
        .creation_time = "CREATION_TIME",
        .name = "NAME",
    };
};
