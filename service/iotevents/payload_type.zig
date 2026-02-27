pub const PayloadType = enum {
    string,
    json,

    pub const json_field_names = .{
        .string = "STRING",
        .json = "JSON",
    };
};
