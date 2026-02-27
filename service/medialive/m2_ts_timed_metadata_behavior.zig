/// M2ts Timed Metadata Behavior
pub const M2tsTimedMetadataBehavior = enum {
    no_passthrough,
    passthrough,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .passthrough = "PASSTHROUGH",
    };
};
