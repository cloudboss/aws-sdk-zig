/// M3u8 Timed Metadata Behavior
pub const M3u8TimedMetadataBehavior = enum {
    no_passthrough,
    passthrough,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .passthrough = "PASSTHROUGH",
    };
};
