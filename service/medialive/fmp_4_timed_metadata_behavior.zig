/// Fmp4 Timed Metadata Behavior
pub const Fmp4TimedMetadataBehavior = enum {
    no_passthrough,
    passthrough,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .passthrough = "PASSTHROUGH",
    };
};
