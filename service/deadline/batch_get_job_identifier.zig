/// The identifiers for a job.
pub const BatchGetJobIdentifier = struct {
    /// The farm ID of the job.
    farm_id: []const u8,

    /// The job ID.
    job_id: []const u8,

    /// The queue ID of the job.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .job_id = "jobId",
        .queue_id = "queueId",
    };
};
