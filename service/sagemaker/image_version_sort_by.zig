pub const ImageVersionSortBy = enum {
    creation_time,
    last_modified_time,
    version,

    pub const json_field_names = .{
        .creation_time = "CREATION_TIME",
        .last_modified_time = "LAST_MODIFIED_TIME",
        .version = "VERSION",
    };
};
