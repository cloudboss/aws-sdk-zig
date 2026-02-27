/// Hls Manifest Compression
pub const HlsManifestCompression = enum {
    gzip,
    none,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .none = "NONE",
    };
};
