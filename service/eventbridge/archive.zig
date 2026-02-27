const ArchiveState = @import("archive_state.zig").ArchiveState;

/// An `Archive` object that contains details about an archive.
pub const Archive = struct {
    /// The name of the archive.
    archive_name: ?[]const u8,

    /// The time stamp for the time that the archive was created.
    creation_time: ?i64,

    /// The number of events in the archive.
    event_count: i64 = 0,

    /// The ARN of the event bus associated with the archive. Only events from this
    /// event bus are
    /// sent to the archive.
    event_source_arn: ?[]const u8,

    /// The number of days to retain events in the archive before they are deleted.
    retention_days: ?i32,

    /// The size of the archive, in bytes.
    size_bytes: i64 = 0,

    /// The current state of the archive.
    state: ?ArchiveState,

    /// A description for the reason that the archive is in the current state.
    state_reason: ?[]const u8,

    pub const json_field_names = .{
        .archive_name = "ArchiveName",
        .creation_time = "CreationTime",
        .event_count = "EventCount",
        .event_source_arn = "EventSourceArn",
        .retention_days = "RetentionDays",
        .size_bytes = "SizeBytes",
        .state = "State",
        .state_reason = "StateReason",
    };
};
