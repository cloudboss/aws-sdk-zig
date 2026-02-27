/// Include or exclude RESOLUTION attribute for video in EXT-X-STREAM-INF tag of
/// variant manifest.
pub const HlsStreamInfResolution = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
