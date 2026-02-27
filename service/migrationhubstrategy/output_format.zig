pub const OutputFormat = enum {
    excel,
    json,

    pub const json_field_names = .{
        .excel = "Excel",
        .json = "Json",
    };
};
