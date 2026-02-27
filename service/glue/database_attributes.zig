pub const DatabaseAttributes = enum {
    name,
    target_database,

    pub const json_field_names = .{
        .name = "NAME",
        .target_database = "TARGET_DATABASE",
    };
};
