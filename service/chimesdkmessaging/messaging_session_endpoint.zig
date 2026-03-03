/// The websocket endpoint used to connect to Amazon Chime SDK messaging.
pub const MessagingSessionEndpoint = struct {
    /// The endpoint to which you establish a websocket connection.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "Url",
    };
};
