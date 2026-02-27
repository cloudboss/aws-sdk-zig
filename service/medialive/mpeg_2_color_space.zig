/// Mpeg2 Color Space
pub const Mpeg2ColorSpace = enum {
    auto,
    passthrough,

    pub const json_field_names = .{
        .auto = "AUTO",
        .passthrough = "PASSTHROUGH",
    };
};
