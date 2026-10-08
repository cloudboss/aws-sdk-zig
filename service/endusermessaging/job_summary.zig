const JobResource = @import("job_resource.zig").JobResource;
const JobStatus = @import("job_status.zig").JobStatus;

/// Contains summary information about an asynchronous job in a list response.
pub const JobSummary = struct {
    /// The brand profile that the job operates on. This value is absent for
    /// operations that create a brand profile.
    brand_profile_id: ?[]const u8 = null,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// A machine-readable code that identifies why the job failed. This value is
    /// present only when the job status is FAILED.
    error_code: ?[]const u8 = null,

    /// A human-readable description of why the job failed. This value is present
    /// only when the job status is FAILED.
    error_message: ?[]const u8 = null,

    /// The unique identifier of the asynchronous job. Use the GetJob operation to
    /// check the status of the job and to retrieve its results.
    job_id: []const u8,

    /// The type of mutating operation that created the job.
    operation_type: []const u8,

    /// The resources that were created or updated by the job.
    resources: ?[]const JobResource = null,

    /// The current lifecycle status of the job.
    status: JobStatus,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .brand_profile_id = "brandProfileId",
        .created_at = "createdAt",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .job_id = "jobId",
        .operation_type = "operationType",
        .resources = "resources",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
