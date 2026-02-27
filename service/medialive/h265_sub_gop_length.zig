/// H265 Sub Gop Length
pub const H265SubGopLength = enum {
    dynamic,
    fixed,

    pub const json_field_names = .{
        .dynamic = "DYNAMIC",
        .fixed = "FIXED",
    };
};
