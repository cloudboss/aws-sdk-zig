const UnprocessedErrorCode = @import("unprocessed_error_code.zig").UnprocessedErrorCode;

/// Provides details about a security control for which a response couldn't be
/// returned.
pub const UnprocessedSecurityControl = struct {
    /// The error code for the unprocessed security control. The `NOT_FOUND` value
    /// has been deprecated and
    /// replaced by the `RESOURCE_NOT_FOUND` value.
    error_code: UnprocessedErrorCode,

    /// The reason why the security control was unprocessed.
    error_reason: ?[]const u8 = null,

    /// The control (identified with `SecurityControlId`,
    /// `SecurityControlArn`, or a mix of both parameters) for which a response
    /// couldn't be returned.
    security_control_id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_reason = "ErrorReason",
        .security_control_id = "SecurityControlId",
    };
};
