/// Contains the configuration details for asynchronous Message Disposition
/// Notification (MDN) responses in AS2 connectors. This configuration specifies
/// where asynchronous MDN responses should be sent and which servers should
/// handle them.
pub const As2AsyncMdnConnectorConfig = struct {
    /// A list of server identifiers that can handle asynchronous MDN responses. You
    /// can specify between 1 and 10 server IDs.
    server_ids: ?[]const []const u8,

    /// The URL endpoint where asynchronous MDN responses should be sent.
    url: ?[]const u8,

    pub const json_field_names = .{
        .server_ids = "ServerIds",
        .url = "Url",
    };
};
