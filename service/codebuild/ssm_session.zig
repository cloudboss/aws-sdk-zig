/// Contains information about the Session Manager session.
pub const SSMSession = struct {
    /// The ID of the session.
    session_id: ?[]const u8,

    /// A URL back to SSM Agent on the managed node that the Session Manager client
    /// uses to send commands and receive output from the node.
    stream_url: ?[]const u8,

    /// An encrypted token value containing session and caller information.
    token_value: ?[]const u8,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stream_url = "streamUrl",
        .token_value = "tokenValue",
    };
};
