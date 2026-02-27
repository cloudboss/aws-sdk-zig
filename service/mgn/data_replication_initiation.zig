const DataReplicationInitiationStep = @import("data_replication_initiation_step.zig").DataReplicationInitiationStep;

/// Data replication initiation.
pub const DataReplicationInitiation = struct {
    /// Request to query next data initiation date and time.
    next_attempt_date_time: ?[]const u8,

    /// Request to query data initiation start date and time.
    start_date_time: ?[]const u8,

    /// Request to query data initiation steps.
    steps: ?[]const DataReplicationInitiationStep,

    pub const json_field_names = .{
        .next_attempt_date_time = "nextAttemptDateTime",
        .start_date_time = "startDateTime",
        .steps = "steps",
    };
};
