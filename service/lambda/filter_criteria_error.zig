/// An object that contains details about an error related to filter criteria
/// encryption.
pub const FilterCriteriaError = struct {
    /// The KMS exception that resulted from filter criteria encryption or
    /// decryption.
    error_code: ?[]const u8,

    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};
