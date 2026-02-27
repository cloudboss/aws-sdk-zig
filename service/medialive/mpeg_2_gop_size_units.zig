/// Mpeg2 Gop Size Units
pub const Mpeg2GopSizeUnits = enum {
    frames,
    seconds,

    pub const json_field_names = .{
        .frames = "FRAMES",
        .seconds = "SECONDS",
    };
};
