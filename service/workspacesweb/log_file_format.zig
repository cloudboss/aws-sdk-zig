pub const LogFileFormat = enum {
    json_lines,
    json,

    pub const json_field_names = .{
        .json_lines = "JSON_LINES",
        .json = "JSON",
    };
};
