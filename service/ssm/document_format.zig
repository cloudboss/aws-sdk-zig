pub const DocumentFormat = enum {
    yaml,
    json,
    text,

    pub const json_field_names = .{
        .yaml = "YAML",
        .json = "JSON",
        .text = "TEXT",
    };
};
