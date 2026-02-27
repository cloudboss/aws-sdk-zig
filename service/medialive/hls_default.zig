/// Hls Default
pub const HlsDefault = enum {
    no,
    omit,
    yes,

    pub const json_field_names = .{
        .no = "NO",
        .omit = "OMIT",
        .yes = "YES",
    };
};
