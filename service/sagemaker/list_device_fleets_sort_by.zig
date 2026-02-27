pub const ListDeviceFleetsSortBy = enum {
    name,
    creation_time,
    last_modified_time,

    pub const json_field_names = .{
        .name = "Name",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
    };
};
