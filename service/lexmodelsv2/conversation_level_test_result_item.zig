const TestResultMatchStatus = @import("test_result_match_status.zig").TestResultMatchStatus;
const ConversationLevelIntentClassificationResultItem = @import("conversation_level_intent_classification_result_item.zig").ConversationLevelIntentClassificationResultItem;
const ConversationLevelSlotResolutionResultItem = @import("conversation_level_slot_resolution_result_item.zig").ConversationLevelSlotResolutionResultItem;

/// The test result evaluation item at the conversation level.
pub const ConversationLevelTestResultItem = struct {
    /// The conversation Id of the test result evaluation item.
    conversation_id: []const u8,

    /// The end-to-end success or failure of the test result evaluation item.
    end_to_end_result: TestResultMatchStatus,

    /// The intent classification of the test result evaluation item.
    intent_classification_results: []const ConversationLevelIntentClassificationResultItem,

    /// The slot success or failure of the test result evaluation item.
    slot_resolution_results: []const ConversationLevelSlotResolutionResultItem,

    /// The speech transcription success or failure of the test result evaluation
    /// item.
    speech_transcription_result: ?TestResultMatchStatus = null,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .end_to_end_result = "endToEndResult",
        .intent_classification_results = "intentClassificationResults",
        .slot_resolution_results = "slotResolutionResults",
        .speech_transcription_result = "speechTranscriptionResult",
    };
};
