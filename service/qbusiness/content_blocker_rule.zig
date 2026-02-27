/// A rule for configuring how Amazon Q Business responds when it encounters a a
/// blocked topic. You can configure a custom message to inform your end users
/// that they have asked about a restricted topic and suggest any next steps
/// they should take.
pub const ContentBlockerRule = struct {
    /// The configured custom message displayed to an end user informing them that
    /// they've used a blocked phrase during chat.
    system_message_override: ?[]const u8,

    pub const json_field_names = .{
        .system_message_override = "systemMessageOverride",
    };
};
