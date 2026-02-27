const IntentClassificationTestResultItemCounts = @import("intent_classification_test_result_item_counts.zig").IntentClassificationTestResultItemCounts;

/// Information for an intent that is classified by the test workbench.
pub const IntentClassificationTestResultItem = struct {
    /// The name of the intent.
    intent_name: []const u8,

    /// Indicates whether the conversation involves multiple turns or not.
    multi_turn_conversation: bool = false,

    /// The result of the intent classification test.
    result_counts: IntentClassificationTestResultItemCounts,

    pub const json_field_names = .{
        .intent_name = "intentName",
        .multi_turn_conversation = "multiTurnConversation",
        .result_counts = "resultCounts",
    };
};
