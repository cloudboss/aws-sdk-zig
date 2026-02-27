const JobErrorCode = @import("job_error_code.zig").JobErrorCode;

/// Contains the details about the policy generation error.
pub const JobError = struct {
    /// The job error code.
    code: JobErrorCode,

    /// Specific information about the error. For example, which service quota was
    /// exceeded or which resource was not found.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
