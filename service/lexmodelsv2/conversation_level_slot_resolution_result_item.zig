const TestResultMatchStatus = @import("test_result_match_status.zig").TestResultMatchStatus;

/// The slots used for the slot resolution in the conversation.
pub const ConversationLevelSlotResolutionResultItem = struct {
    /// The intents used in the slots list for the slot resolution details.
    intent_name: []const u8,

    /// The number of matching slots used in the slots listings for the slot
    /// resolution evaluation.
    match_result: TestResultMatchStatus,

    /// The slot name in the slots list for the slot resolution details.
    slot_name: []const u8,

    pub const json_field_names = .{
        .intent_name = "intentName",
        .match_result = "matchResult",
        .slot_name = "slotName",
    };
};
