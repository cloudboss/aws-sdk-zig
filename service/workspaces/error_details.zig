const WorkspaceImageErrorDetailCode = @import("workspace_image_error_detail_code.zig").WorkspaceImageErrorDetailCode;

/// Describes in-depth details about the error. These details include the
/// possible causes of the error and troubleshooting information.
pub const ErrorDetails = struct {
    /// Indicates the error code returned.
    error_code: ?WorkspaceImageErrorDetailCode = null,

    /// The text of the error message related the error code.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
