pub const InferenceComponentSortKey = enum {
    name,
    creation_time,
    status,

    pub const json_field_names = .{
        .name = "Name",
        .creation_time = "CreationTime",
        .status = "Status",
    };
};
