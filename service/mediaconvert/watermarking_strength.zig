/// Optional. Ignore this setting unless Nagra support directs you to specify a
/// value. When you don't specify a value here, the Nagra NexGuard library uses
/// its default value.
pub const WatermarkingStrength = enum {
    lightest,
    lighter,
    default,
    stronger,
    strongest,

    pub const json_field_names = .{
        .lightest = "LIGHTEST",
        .lighter = "LIGHTER",
        .default = "DEFAULT",
        .stronger = "STRONGER",
        .strongest = "STRONGEST",
    };
};
