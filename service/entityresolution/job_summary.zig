const JobStatus = @import("job_status.zig").JobStatus;

/// An object containing the `jobId`, `status`, `startTime`, and `endTime` of a
/// job.
pub const JobSummary = struct {
    /// The time at which the job has finished.
    end_time: ?i64,

    /// The ID of the job.
    job_id: []const u8,

    /// The time at which the job was started.
    start_time: i64,

    /// The current status of the job.
    status: JobStatus,

    pub const json_field_names = .{
        .end_time = "endTime",
        .job_id = "jobId",
        .start_time = "startTime",
        .status = "status",
    };
};
