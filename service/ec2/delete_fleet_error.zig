const DeleteFleetErrorCode = @import("delete_fleet_error_code.zig").DeleteFleetErrorCode;

/// Describes an EC2 Fleet error.
pub const DeleteFleetError = struct {
    /// The error code.
    code: ?DeleteFleetErrorCode = null,

    /// The description for the error code.
    message: ?[]const u8 = null,
};
