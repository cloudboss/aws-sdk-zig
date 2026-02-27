pub const CompressionEnum = enum {
    zlib,
    disabled,

    pub const json_field_names = .{
        .zlib = "ZLIB",
        .disabled = "DISABLED",
    };
};
