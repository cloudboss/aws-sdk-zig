pub const CodeRepositorySortBy = enum {
    name,
    creation_time,
    last_modified_time,

    pub const json_field_names = .{
        .name = "NAME",
        .creation_time = "CREATION_TIME",
        .last_modified_time = "LAST_MODIFIED_TIME",
    };
};
