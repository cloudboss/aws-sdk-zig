/// An object that contains details about an error related to retrieving tags.
pub const TagsError = struct {
    /// The error code.
    error_code: []const u8,

    /// The error message.
    message: []const u8,
};
