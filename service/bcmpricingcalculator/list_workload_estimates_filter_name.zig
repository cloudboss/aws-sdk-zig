pub const ListWorkloadEstimatesFilterName = enum {
    status,
    name,

    pub const json_field_names = .{
        .status = "STATUS",
        .name = "NAME",
    };
};
