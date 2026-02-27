pub const MessageFormatValue = enum {
    json,
    json_unformatted,

    pub const json_field_names = .{
        .json = "JSON",
        .json_unformatted = "JSON_UNFORMATTED",
    };
};
