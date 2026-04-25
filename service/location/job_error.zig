const JobErrorCode = @import("job_error_code.zig").JobErrorCode;

/// Error information for failed jobs.
pub const JobError = struct {
    /// Error code indicating the type of error that occurred.
    code: JobErrorCode,

    /// Error messages providing details about the failure.
    messages: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .messages = "Messages",
    };
};
