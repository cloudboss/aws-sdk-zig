pub const EncodingType = enum {
    binary,
    json,

    pub const json_field_names = .{
        .binary = "binary",
        .json = "json",
    };
};
