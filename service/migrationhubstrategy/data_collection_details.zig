const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;

/// Detailed information about an assessment.
pub const DataCollectionDetails = struct {
    /// The time the assessment completes.
    completion_time: ?i64 = null,

    /// The number of failed servers in the assessment.
    failed: ?i32 = null,

    /// The number of servers with the assessment status `IN_PROGESS`.
    in_progress: ?i32 = null,

    /// The total number of servers in the assessment.
    servers: ?i32 = null,

    /// The start time of assessment.
    start_time: ?i64 = null,

    /// The status of the assessment.
    status: ?AssessmentStatus = null,

    /// The status message of the assessment.
    status_message: ?[]const u8 = null,

    /// The number of successful servers in the assessment.
    success: ?i32 = null,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .failed = "failed",
        .in_progress = "inProgress",
        .servers = "servers",
        .start_time = "startTime",
        .status = "status",
        .status_message = "statusMessage",
        .success = "success",
    };
};
