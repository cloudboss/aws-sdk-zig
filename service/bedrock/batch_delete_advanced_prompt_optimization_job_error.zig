/// Contains information about an error that occurred when deleting an advanced
/// prompt optimization job.
pub const BatchDeleteAdvancedPromptOptimizationJobError = struct {
    /// The error code for the deletion failure.
    code: []const u8,

    /// The identifier of the job that could not be deleted.
    job_identifier: []const u8,

    /// A message describing the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .job_identifier = "jobIdentifier",
        .message = "message",
    };
};
