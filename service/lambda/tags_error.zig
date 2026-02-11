/// An object that contains details about an error related to retrieving tags.
pub const TagsError = struct {
    /// The error code.
    error_code: []const u8,

    /// The error message.
    message: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};
