/// Pairs an asynchronous job with the resource identifier from your request
/// that the job processes.
pub const JobResult = struct {
    /// The unique identifier of the asynchronous job. Use the GetJob operation to
    /// check the status of the job and to retrieve its results.
    job_id: []const u8,

    /// The identifier from your request that this job is processing.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .resource_identifier = "resourceIdentifier",
    };
};
