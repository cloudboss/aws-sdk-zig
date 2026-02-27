const SlotResolutionTestResultItem = @import("slot_resolution_test_result_item.zig").SlotResolutionTestResultItem;

/// Information about intent-level slot resolution in a test result.
pub const IntentLevelSlotResolutionTestResultItem = struct {
    /// The name of the intent that was recognized.
    intent_name: []const u8,

    /// Indicates whether the conversation involves multiple turns or not.
    multi_turn_conversation: bool = false,

    /// The results for the slot resolution in the test execution result.
    slot_resolution_results: []const SlotResolutionTestResultItem,

    pub const json_field_names = .{
        .intent_name = "intentName",
        .multi_turn_conversation = "multiTurnConversation",
        .slot_resolution_results = "slotResolutionResults",
    };
};
