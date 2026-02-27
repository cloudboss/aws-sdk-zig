pub const OrcCompression = enum {
    none,
    zlib,
    snappy,

    pub const json_field_names = .{
        .none = "NONE",
        .zlib = "ZLIB",
        .snappy = "SNAPPY",
    };
};
