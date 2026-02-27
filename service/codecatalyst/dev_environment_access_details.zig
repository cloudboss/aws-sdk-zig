/// Information about connection details for a Dev Environment.
pub const DevEnvironmentAccessDetails = struct {
    /// The URL used to send commands to and from the Dev Environment.
    stream_url: []const u8,

    /// An encrypted token value that contains session and caller information used
    /// to authenticate the connection.
    token_value: []const u8,

    pub const json_field_names = .{
        .stream_url = "streamUrl",
        .token_value = "tokenValue",
    };
};
