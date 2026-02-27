/// Embedded Scte20 Detection
pub const EmbeddedScte20Detection = enum {
    auto,
    off,

    pub const json_field_names = .{
        .auto = "AUTO",
        .off = "OFF",
    };
};
