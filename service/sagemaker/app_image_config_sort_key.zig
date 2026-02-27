pub const AppImageConfigSortKey = enum {
    creation_time,
    last_modified_time,
    name,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};
