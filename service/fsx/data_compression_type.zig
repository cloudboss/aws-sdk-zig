pub const DataCompressionType = enum {
    none,
    lz4,

    pub const json_field_names = .{
        .none = "NONE",
        .lz4 = "LZ4",
    };
};
