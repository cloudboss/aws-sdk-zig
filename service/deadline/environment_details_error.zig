const JobEntityErrorCode = @import("job_entity_error_code.zig").JobEntityErrorCode;

/// The error details for the environment.
pub const EnvironmentDetailsError = struct {
    /// The error code.
    code: JobEntityErrorCode,

    /// The environment ID.
    environment_id: []const u8,

    /// The job ID.
    job_id: []const u8,

    /// The error message detailing the error's cause.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .environment_id = "environmentId",
        .job_id = "jobId",
        .message = "message",
    };
};
