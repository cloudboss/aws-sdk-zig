const FleetErrorCode = @import("fleet_error_code.zig").FleetErrorCode;

/// Describes a resource error.
pub const ResourceError = struct {
    /// The error code.
    error_code: ?FleetErrorCode = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    /// The time the error occurred.
    error_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .error_timestamp = "ErrorTimestamp",
    };
};
