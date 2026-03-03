/// Information about a segment that failed processing.
pub const UnprocessedTraceSegment = struct {
    /// The error that caused processing to fail.
    error_code: ?[]const u8 = null,

    /// The segment's ID.
    id: ?[]const u8 = null,

    /// The error message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .id = "Id",
        .message = "Message",
    };
};
