const ErrorCode = @import("error_code.zig").ErrorCode;

/// The list of errors returned when errors are encountered during the
/// BatchSuspendUser, BatchUnsuspendUser, or
/// BatchUpdateUser actions. This includes user IDs, error codes, and error
/// messages.
pub const UserError = struct {
    /// The error code.
    error_code: ?ErrorCode = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    /// The user ID for which the action failed.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .user_id = "UserId",
    };
};
