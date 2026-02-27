/// Describes in-depth details about the error. These details include the
/// possible causes of the error and troubleshooting information.
pub const CustomWorkspaceImageImportErrorDetails = struct {
    /// The error code that is returned for the image import.
    error_code: ?[]const u8,

    /// The text of the error message that is returned for the image import.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
