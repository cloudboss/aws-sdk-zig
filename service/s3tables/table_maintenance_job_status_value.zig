const JobStatus = @import("job_status.zig").JobStatus;

/// Details about the status of a maintenance job.
pub const TableMaintenanceJobStatusValue = struct {
    /// The failure message of a failed job.
    failure_message: ?[]const u8,

    /// The date and time that the maintenance job was last run.
    last_run_timestamp: ?i64,

    /// The status of the job.
    status: JobStatus,

    pub const json_field_names = .{
        .failure_message = "failureMessage",
        .last_run_timestamp = "lastRunTimestamp",
        .status = "status",
    };
};
