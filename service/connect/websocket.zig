/// The websocket that a chat participant uses to receive messages and events
/// for the chat.
pub const Websocket = struct {
    /// The expiration of the websocket URL. It's specified in ISO 8601 format:
    /// yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    connection_expiry: ?[]const u8 = null,

    /// The URL of the websocket.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_expiry = "ConnectionExpiry",
        .url = "Url",
    };
};
