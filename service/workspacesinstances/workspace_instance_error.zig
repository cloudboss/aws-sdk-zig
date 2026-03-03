/// Captures errors specific to WorkSpace Instance operations.
pub const WorkspaceInstanceError = struct {
    /// Unique error code for the WorkSpace Instance error.
    error_code: ?[]const u8 = null,

    /// Detailed description of the WorkSpace Instance error.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
