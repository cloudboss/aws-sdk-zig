pub const OutputCompressionType = enum {
    gzip,
    none,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .none = "NONE",
    };
};
