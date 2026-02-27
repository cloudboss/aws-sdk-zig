/// Used to enable or disable email sending for messages that use this
/// configuration set
/// in the current AWS Region.
pub const SendingOptions = struct {
    /// If `true`, email sending is enabled for the configuration set. If
    /// `false`, email sending is disabled for the configuration set.
    sending_enabled: bool = false,

    pub const json_field_names = .{
        .sending_enabled = "SendingEnabled",
    };
};
