const ArrayJobDependency = @import("array_job_dependency.zig").ArrayJobDependency;

/// An object that represents an Batch job dependency.
pub const JobDependency = struct {
    /// The job ID of the Batch job that's associated with this dependency.
    job_id: ?[]const u8,

    /// The type of the job dependency.
    type: ?ArrayJobDependency,

    pub const json_field_names = .{
        .job_id = "jobId",
        .type = "type",
    };
};
