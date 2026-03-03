const aws = @import("aws");

/// A tuple that provides information about an error that caused a cluster to
/// terminate.
pub const ErrorDetail = struct {
    /// The name or code associated with the error.
    error_code: ?[]const u8 = null,

    /// A list of key value pairs that provides contextual information about why an
    /// error
    /// occured.
    error_data: ?[]const []const aws.map.StringMapEntry = null,

    /// A message that describes the error.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_data = "ErrorData",
        .error_message = "ErrorMessage",
    };
};
