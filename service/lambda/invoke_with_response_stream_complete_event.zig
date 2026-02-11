/// A response confirming that the event stream is complete.
pub const InvokeWithResponseStreamCompleteEvent = struct {
    /// An error code.
    error_code: ?[]const u8,

    /// The details of any returned error.
    error_details: ?[]const u8,

    /// The last 4 KB of the execution log, which is base64-encoded.
    log_result: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_details = "ErrorDetails",
        .log_result = "LogResult",
    };
};
