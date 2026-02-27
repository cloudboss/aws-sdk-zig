/// Provides information about an API request or response.
pub const MessageBody = struct {
    /// The message that's returned from the API.
    message: ?[]const u8,

    /// The unique identifier for the request or response.
    request_id: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
        .request_id = "RequestID",
    };
};
