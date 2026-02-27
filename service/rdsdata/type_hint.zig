pub const TypeHint = enum {
    json,
    uuid,
    timestamp,
    date,
    time,
    decimal,

    pub const json_field_names = .{
        .json = "JSON",
        .uuid = "UUID",
        .timestamp = "TIMESTAMP",
        .date = "DATE",
        .time = "TIME",
        .decimal = "DECIMAL",
    };
};
