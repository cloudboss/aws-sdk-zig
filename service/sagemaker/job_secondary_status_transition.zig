const JobSecondaryStatus = @import("job_secondary_status.zig").JobSecondaryStatus;

/// Represents a secondary status transition for a job. Jobs progress through
/// multiple secondary statuses during execution. Each transition records the
/// status, start time, optional end time, and an optional message with
/// additional details.
pub const JobSecondaryStatusTransition = struct {
    /// The date and time that the status transition ended.
    end_time: ?i64 = null,

    /// The date and time that the status transition started.
    start_time: i64,

    /// The secondary status of the job at this transition point.
    status: JobSecondaryStatus,

    /// A detailed message about the status transition.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
