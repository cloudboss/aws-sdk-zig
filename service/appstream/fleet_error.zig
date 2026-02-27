const FleetErrorCode = @import("fleet_error_code.zig").FleetErrorCode;

/// Describes a fleet error.
pub const FleetError = struct {
    /// The error code.
    error_code: ?FleetErrorCode,

    /// The error message.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
