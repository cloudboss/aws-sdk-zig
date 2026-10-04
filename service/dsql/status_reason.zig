const StreamFailureErrorCode = @import("stream_failure_error_code.zig").StreamFailureErrorCode;

/// Stream status reason with error and timestamp.
pub const StatusReason = struct {
    /// The error code for the stream failure.
    @"error": StreamFailureErrorCode,

    /// The timestamp when the status was updated.
    updated_at: i64,

    pub const json_field_names = .{
        .@"error" = "error",
        .updated_at = "updatedAt",
    };
};
