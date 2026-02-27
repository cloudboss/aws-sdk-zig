/// Specifies the status and settings of the ADM (Amazon Device Messaging)
/// channel for an application.
pub const ADMChannelRequest = struct {
    /// The Client ID that you received from Amazon to send messages by using ADM.
    client_id: []const u8,

    /// The Client Secret that you received from Amazon to send messages by using
    /// ADM.
    client_secret: []const u8,

    /// Specifies whether to enable the ADM channel for the application.
    enabled: ?bool,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .enabled = "Enabled",
    };
};
