pub const SortPipelinesBy = enum {
    name,
    creation_time,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_time = "CREATION_TIME",
    };
};
