const JobEntityErrorCode = @import("job_entity_error_code.zig").JobEntityErrorCode;

/// The details of the step error.
pub const StepDetailsError = struct {
    /// The error code.
    code: JobEntityErrorCode,

    /// The job ID.
    job_id: []const u8,

    /// The error message detailing the error's cause.
    message: []const u8,

    /// The step ID.
    step_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .job_id = "jobId",
        .message = "message",
        .step_id = "stepId",
    };
};
