/// Hls Stream Inf Resolution
pub const HlsStreamInfResolution = enum {
    exclude,
    include,

    pub const json_field_names = .{
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
    };
};
