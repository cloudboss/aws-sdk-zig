/// Configuration that defines how to parse JSON responses from REST API calls,
/// including paths to result data and error information.
pub const ResponseConfiguration = struct {
    /// The JSON path expression that identifies where error information is located
    /// within API responses when requests fail.
    error_path: ?[]const u8 = null,

    /// The JSON path expression that identifies where the actual result data is
    /// located within the API response.
    result_path: []const u8,

    pub const json_field_names = .{
        .error_path = "ErrorPath",
        .result_path = "ResultPath",
    };
};
