/// Specifies the status and settings of the SMS channel for an application.
pub const SMSChannelRequest = struct {
    /// Specifies whether to enable the SMS channel for the application.
    enabled: ?bool = null,

    /// The identity that you want to display on recipients' devices when they
    /// receive messages from the SMS channel.
    sender_id: ?[]const u8 = null,

    /// The registered short code that you want to use when you send messages
    /// through the SMS channel.
    short_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .sender_id = "SenderId",
        .short_code = "ShortCode",
    };
};
