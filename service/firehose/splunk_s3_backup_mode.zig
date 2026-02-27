pub const SplunkS3BackupMode = enum {
    failed_events_only,
    all_events,

    pub const json_field_names = .{
        .failed_events_only = "FailedEventsOnly",
        .all_events = "AllEvents",
    };
};
