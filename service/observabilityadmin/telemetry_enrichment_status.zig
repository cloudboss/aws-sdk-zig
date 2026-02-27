pub const TelemetryEnrichmentStatus = enum {
    running,
    stopped,
    impaired,

    pub const json_field_names = .{
        .running = "RUNNING",
        .stopped = "STOPPED",
        .impaired = "IMPAIRED",
    };
};
