/// Provides information about the phrases blocked from chat by your chat
/// control configuration.
pub const BlockedPhrasesConfiguration = struct {
    /// A list of phrases blocked from a Amazon Q Business web experience chat.
    ///
    /// Each phrase can contain a maximum of 36 characters. The list can contain a
    /// maximum of 20 phrases.
    blocked_phrases: ?[]const []const u8,

    /// The configured custom message displayed to an end user informing them that
    /// they've used a blocked phrase during chat.
    system_message_override: ?[]const u8,

    pub const json_field_names = .{
        .blocked_phrases = "blockedPhrases",
        .system_message_override = "systemMessageOverride",
    };
};
