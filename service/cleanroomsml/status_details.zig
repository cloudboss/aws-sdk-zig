/// Details about the status of a resource.
pub const StatusDetails = struct {
    /// The error message that was returned. The message is intended for human
    /// consumption and can change at any time. Use the `statusCode` for
    /// programmatic error handling.
    message: ?[]const u8 = null,

    /// The status code that was returned. The status code is intended for
    /// programmatic error handling. Clean Rooms ML will not change the status code
    /// for existing error conditions.
    status_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .status_code = "statusCode",
    };
};
