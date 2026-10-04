const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains the details of an error associated with a workspace.
pub const WorkspaceErrorDetails = struct {
    /// The error code.
    code: ErrorCode,

    /// The error message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
