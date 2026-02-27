const OperationName = @import("operation_name.zig").OperationName;
const JobProgressSummary = @import("job_progress_summary.zig").JobProgressSummary;
const JobStatus = @import("job_status.zig").JobStatus;

/// Contains the configuration and status information for a single job retrieved
/// as part of
/// a job list.
pub const JobListDescriptor = struct {
    /// A timestamp indicating when the specified job was created.
    creation_time: ?i64,

    /// The user-specified description that was included in the specified job's
    /// `Create
    /// Job` request.
    description: ?[]const u8,

    /// The ID for the specified job.
    job_id: ?[]const u8,

    /// The operation that the specified job is configured to run on every object
    /// listed in the
    /// manifest.
    operation: ?OperationName,

    /// The current priority for the specified job.
    priority: i32 = 0,

    /// Describes the total number of tasks that the specified job has run, the
    /// number of tasks
    /// that succeeded, and the number of tasks that failed.
    progress_summary: ?JobProgressSummary,

    /// The specified job's current status.
    status: ?JobStatus,

    /// A timestamp indicating when the specified job terminated. A job's
    /// termination date is
    /// the date and time when it succeeded, failed, or was canceled.
    termination_date: ?i64,
};
