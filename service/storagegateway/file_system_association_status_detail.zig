/// Detailed information on file system association status.
pub const FileSystemAssociationStatusDetail = struct {
    /// The error code for a given file system association status.
    error_code: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
    };
};
