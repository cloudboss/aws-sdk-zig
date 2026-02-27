pub const PiiEntitiesDetectionMode = enum {
    only_redaction,
    only_offsets,

    pub const json_field_names = .{
        .only_redaction = "ONLY_REDACTION",
        .only_offsets = "ONLY_OFFSETS",
    };
};
