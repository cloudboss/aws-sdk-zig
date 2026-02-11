pub const LogFormat = enum {
    json,
    text,

    pub const json_field_names = .{
        .json = "Json",
        .text = "Text",
    };
};
