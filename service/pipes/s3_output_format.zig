pub const S3OutputFormat = enum {
    json,
    plain,
    w3_c,

    pub const json_field_names = .{
        .json = "JSON",
        .plain = "PLAIN",
        .w3_c = "W3C",
    };
};
