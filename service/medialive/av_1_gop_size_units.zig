/// Av1 Gop Size Units
pub const Av1GopSizeUnits = enum {
    frames,
    seconds,

    pub const json_field_names = .{
        .frames = "FRAMES",
        .seconds = "SECONDS",
    };
};
