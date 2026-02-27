/// H265 Gop Size Units
pub const H265GopSizeUnits = enum {
    frames,
    seconds,

    pub const json_field_names = .{
        .frames = "FRAMES",
        .seconds = "SECONDS",
    };
};
