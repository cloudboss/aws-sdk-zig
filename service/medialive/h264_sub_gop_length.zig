/// H264 Sub Gop Length
pub const H264SubGopLength = enum {
    dynamic,
    fixed,

    pub const json_field_names = .{
        .dynamic = "DYNAMIC",
        .fixed = "FIXED",
    };
};
