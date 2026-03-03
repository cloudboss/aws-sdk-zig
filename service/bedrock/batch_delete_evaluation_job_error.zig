/// A JSON array that provides the status of the evaluation jobs being deleted.
pub const BatchDeleteEvaluationJobError = struct {
    /// A HTTP status code of the evaluation job being deleted.
    code: []const u8,

    /// The ARN of the evaluation job being deleted.
    job_identifier: []const u8,

    /// A status message about the evaluation job deletion.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .job_identifier = "jobIdentifier",
        .message = "message",
    };
};
