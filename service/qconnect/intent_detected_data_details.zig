const RelevanceLevel = @import("relevance_level.zig").RelevanceLevel;

/// Details about the detected intent.
pub const IntentDetectedDataDetails = struct {
    /// The detected intent.
    intent: []const u8,

    /// The identifier of the detected intent.
    intent_id: []const u8,

    /// The relevance level of the detected intent.
    relevance_level: ?RelevanceLevel = null,

    pub const json_field_names = .{
        .intent = "intent",
        .intent_id = "intentId",
        .relevance_level = "relevanceLevel",
    };
};
