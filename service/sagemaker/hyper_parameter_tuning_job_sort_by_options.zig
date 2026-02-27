pub const HyperParameterTuningJobSortByOptions = enum {
    name,
    status,
    creation_time,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
        .creation_time = "CreationTime",
    };
};
