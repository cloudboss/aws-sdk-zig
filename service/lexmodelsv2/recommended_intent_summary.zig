/// An object that contains a summary of a recommended intent.
pub const RecommendedIntentSummary = struct {
    /// The unique identifier of a recommended intent associated with the
    /// bot recommendation.
    intent_id: ?[]const u8 = null,

    /// The name of a recommended intent associated with the bot
    /// recommendation.
    intent_name: ?[]const u8 = null,

    /// The count of sample utterances of a recommended intent that is
    /// associated with a bot recommendation.
    sample_utterances_count: ?i32 = null,

    pub const json_field_names = .{
        .intent_id = "intentId",
        .intent_name = "intentName",
        .sample_utterances_count = "sampleUtterancesCount",
    };
};
