const JobStatusDetails = @import("job_status_details.zig").JobStatusDetails;

/// For a Distillation job, the status details for the data processing sub-task
/// of the job.
pub const DataProcessingDetails = struct {
    /// The start time of the data processing sub-task of the job.
    creation_time: ?i64 = null,

    /// The latest update to the data processing sub-task of the job.
    last_modified_time: ?i64 = null,

    /// The status of the data processing sub-task of the job.
    status: ?JobStatusDetails = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .last_modified_time = "lastModifiedTime",
        .status = "status",
    };
};
