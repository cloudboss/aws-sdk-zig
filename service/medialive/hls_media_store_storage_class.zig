/// Hls Media Store Storage Class
pub const HlsMediaStoreStorageClass = enum {
    temporal,

    pub const json_field_names = .{
        .temporal = "TEMPORAL",
    };
};
