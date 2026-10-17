const TrainingSessionStatus = @import("training_session_status.zig").TrainingSessionStatus;

/// Contains summary information about a training session.
pub const TrainingSessionSummary = struct {
    /// The date and time that the training session was created.
    creation_time: i64,

    /// The date and time that the training session was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the training session.
    training_session_arn: []const u8,

    /// The current status of the training session.
    training_session_status: TrainingSessionStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .training_session_arn = "TrainingSessionArn",
        .training_session_status = "TrainingSessionStatus",
    };
};
