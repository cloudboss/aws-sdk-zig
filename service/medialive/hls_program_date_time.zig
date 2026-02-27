/// Hls Program Date Time
pub const HlsProgramDateTime = enum {
    exclude,
    include,

    pub const json_field_names = .{
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
    };
};
