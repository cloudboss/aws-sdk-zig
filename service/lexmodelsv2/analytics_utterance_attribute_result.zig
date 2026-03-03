/// An object containing the intent that the bot mapped the utterance to.
pub const AnalyticsUtteranceAttributeResult = struct {
    /// The intent that the bot mapped the utterance to.
    last_used_intent: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_used_intent = "lastUsedIntent",
    };
};
