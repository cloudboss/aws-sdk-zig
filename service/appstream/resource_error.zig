const FleetErrorCode = @import("fleet_error_code.zig").FleetErrorCode;

/// Describes a resource error.
pub const ResourceError = struct {
    /// The error code.
    error_code: ?FleetErrorCode,

    /// The error message.
    error_message: ?[]const u8,

    /// The time the error occurred.
    error_timestamp: ?i64,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .error_timestamp = "ErrorTimestamp",
    };
};
