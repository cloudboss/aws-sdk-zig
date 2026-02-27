/// The websocket for the participant's connection.
pub const Websocket = struct {
    /// The URL expiration timestamp in ISO date format.
    ///
    /// It's specified in ISO 8601 format: yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    connection_expiry: ?[]const u8,

    /// The URL of the websocket.
    url: ?[]const u8,

    pub const json_field_names = .{
        .connection_expiry = "ConnectionExpiry",
        .url = "Url",
    };
};
