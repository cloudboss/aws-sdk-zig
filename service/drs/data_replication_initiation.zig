const DataReplicationInitiationStep = @import("data_replication_initiation_step.zig").DataReplicationInitiationStep;

/// Data replication initiation.
pub const DataReplicationInitiation = struct {
    /// The date and time of the next attempt to initiate data replication.
    next_attempt_date_time: ?[]const u8,

    /// The date and time of the current attempt to initiate data replication.
    start_date_time: ?[]const u8,

    /// The steps of the current attempt to initiate data replication.
    steps: ?[]const DataReplicationInitiationStep,

    pub const json_field_names = .{
        .next_attempt_date_time = "nextAttemptDateTime",
        .start_date_time = "startDateTime",
        .steps = "steps",
    };
};
