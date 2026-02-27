pub const CompressionType = enum {
    gzip,
    bzip2,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .bzip2 = "BZIP2",
    };
};
