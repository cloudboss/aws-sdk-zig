/// Specify the units for GOP size. If you don't specify a value here, by
/// default the encoder measures GOP size in frames.
pub const Mpeg2GopSizeUnits = enum {
    frames,
    seconds,

    pub const json_field_names = .{
        .frames = "FRAMES",
        .seconds = "SECONDS",
    };
};
