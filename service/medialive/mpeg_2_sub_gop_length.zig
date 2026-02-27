/// Mpeg2 Sub Gop Length
pub const Mpeg2SubGopLength = enum {
    dynamic,
    fixed,

    pub const json_field_names = .{
        .dynamic = "DYNAMIC",
        .fixed = "FIXED",
    };
};
