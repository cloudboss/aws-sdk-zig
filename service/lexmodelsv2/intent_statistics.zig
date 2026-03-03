/// The object that contains the statistical summary of recommended
/// intents associated with the bot recommendation.
pub const IntentStatistics = struct {
    /// The number of recommended intents associated with the bot
    /// recommendation.
    discovered_intent_count: ?i32 = null,

    pub const json_field_names = .{
        .discovered_intent_count = "discoveredIntentCount",
    };
};
