const JobStatusDetails = @import("job_status_details.zig").JobStatusDetails;

/// For a Distillation job, the status details for the validation sub-task of
/// the job.
pub const ValidationDetails = struct {
    /// The start time of the validation sub-task of the job.
    creation_time: ?i64,

    /// The latest update to the validation sub-task of the job.
    last_modified_time: ?i64,

    /// The status of the validation sub-task of the job.
    status: ?JobStatusDetails,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .last_modified_time = "lastModifiedTime",
        .status = "status",
    };
};
