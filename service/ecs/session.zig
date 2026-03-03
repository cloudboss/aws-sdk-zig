/// The details for the execute command session.
pub const Session = struct {
    /// The ID of the execute command session.
    session_id: ?[]const u8 = null,

    /// A URL to the managed agent on the container that the SSM Session Manager
    /// client uses
    /// to send commands and receive output from the container.
    stream_url: ?[]const u8 = null,

    /// An encrypted token value containing session and caller information. It's
    /// used to
    /// authenticate the connection to the container.
    token_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stream_url = "streamUrl",
        .token_value = "tokenValue",
    };
};
