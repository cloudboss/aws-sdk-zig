const aws = @import("aws");

const JobExecutionStatus = @import("job_execution_status.zig").JobExecutionStatus;

/// Contains data about the state of a job execution.
pub const JobExecutionState = struct {
    /// The status of the job execution. Can be one of: "QUEUED", "IN_PROGRESS",
    /// "FAILED",
    /// "SUCCESS", "CANCELED", "TIMED_OUT", "REJECTED", or "REMOVED".
    status: ?JobExecutionStatus,

    /// A collection of name/value pairs that describe the status of the job
    /// execution.
    ///
    /// The maximum length of the value in the name/value pair is 1,024 characters.
    status_details: ?[]const aws.map.StringMapEntry,

    /// The version of the job execution. Job execution versions are incremented
    /// each time
    /// they are updated by a device.
    version_number: i64 = 0,

    pub const json_field_names = .{
        .status = "status",
        .status_details = "statusDetails",
        .version_number = "versionNumber",
    };
};
