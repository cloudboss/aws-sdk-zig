/// Hls Iv In Manifest
pub const HlsIvInManifest = enum {
    exclude,
    include,

    pub const json_field_names = .{
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
    };
};
