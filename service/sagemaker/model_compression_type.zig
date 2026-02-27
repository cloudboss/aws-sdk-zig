pub const ModelCompressionType = enum {
    none,
    gzip,

    pub const json_field_names = .{
        .none = "None",
        .gzip = "Gzip",
    };
};
