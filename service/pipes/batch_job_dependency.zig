const BatchJobDependencyType = @import("batch_job_dependency_type.zig").BatchJobDependencyType;

/// An object that represents an Batch job dependency.
pub const BatchJobDependency = struct {
    /// The job ID of the Batch job that's associated with this
    /// dependency.
    job_id: ?[]const u8,

    /// The type of the job dependency.
    type: ?BatchJobDependencyType,

    pub const json_field_names = .{
        .job_id = "JobId",
        .type = "Type",
    };
};
