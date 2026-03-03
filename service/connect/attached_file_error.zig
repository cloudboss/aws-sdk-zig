/// Error describing a failure to retrieve attached file metadata through
/// BatchGetAttachedFileMetadata
/// action.
pub const AttachedFileError = struct {
    /// Status code describing the failure.
    error_code: ?[]const u8 = null,

    /// Why the attached file couldn't be retrieved.
    error_message: ?[]const u8 = null,

    /// The unique identifier of the attached file resource.
    file_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .file_id = "FileId",
    };
};
