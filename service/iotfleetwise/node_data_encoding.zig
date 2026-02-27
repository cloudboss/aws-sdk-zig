pub const NodeDataEncoding = enum {
    binary,
    typed,

    pub const json_field_names = .{
        .binary = "BINARY",
        .typed = "TYPED",
    };
};
