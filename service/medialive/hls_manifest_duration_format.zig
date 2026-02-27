/// Hls Manifest Duration Format
pub const HlsManifestDurationFormat = enum {
    floating_point,
    integer,

    pub const json_field_names = .{
        .floating_point = "FLOATING_POINT",
        .integer = "INTEGER",
    };
};
