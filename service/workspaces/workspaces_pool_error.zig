const WorkspacesPoolErrorCode = @import("workspaces_pool_error_code.zig").WorkspacesPoolErrorCode;

/// Describes a pool error.
pub const WorkspacesPoolError = struct {
    /// The error code.
    error_code: ?WorkspacesPoolErrorCode = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
