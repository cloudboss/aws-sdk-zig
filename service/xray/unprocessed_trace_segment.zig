/// Information about a segment that failed processing.
pub const UnprocessedTraceSegment = struct {
    /// The error that caused processing to fail.
    error_code: ?[]const u8,

    /// The segment's ID.
    id: ?[]const u8,

    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .id = "Id",
        .message = "Message",
    };
};
