pub const ModelSortKey = enum {
    name,
    creation_time,

    pub const json_field_names = .{
        .name = "Name",
        .creation_time = "CreationTime",
    };
};
