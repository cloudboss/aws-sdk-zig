const ConversationLevelTestResults = @import("conversation_level_test_results.zig").ConversationLevelTestResults;
const IntentClassificationTestResults = @import("intent_classification_test_results.zig").IntentClassificationTestResults;
const IntentLevelSlotResolutionTestResults = @import("intent_level_slot_resolution_test_results.zig").IntentLevelSlotResolutionTestResults;
const OverallTestResults = @import("overall_test_results.zig").OverallTestResults;
const UtteranceLevelTestResults = @import("utterance_level_test_results.zig").UtteranceLevelTestResults;

/// Contains the results of the test execution, grouped by type of results.
/// See [Test result details">Test results
/// details](https://docs.aws.amazon.com/lexv2/latest/dg/test-results-details-test-set.html)
/// for details about different types of results.
pub const TestExecutionResultItems = struct {
    /// Results related to conversations in the test set, including metrics about
    /// success and failure of
    /// conversations and intent and slot failures.
    conversation_level_test_results: ?ConversationLevelTestResults,

    /// Intent recognition results aggregated by intent name. The aggregated results
    /// contain success and failure rates of intent recognition,
    /// speech transcriptions, and end-to-end conversations.
    intent_classification_test_results: ?IntentClassificationTestResults,

    /// Slot resolution results aggregated by intent and slot name. The aggregated
    /// results contain success and failure rates of slot resolution,
    /// speech transcriptions, and end-to-end conversations
    intent_level_slot_resolution_test_results: ?IntentLevelSlotResolutionTestResults,

    /// Overall results for the test execution, including the breakdown of
    /// conversations and
    /// single-input utterances.
    overall_test_results: ?OverallTestResults,

    /// Results related to utterances in the test set.
    utterance_level_test_results: ?UtteranceLevelTestResults,

    pub const json_field_names = .{
        .conversation_level_test_results = "conversationLevelTestResults",
        .intent_classification_test_results = "intentClassificationTestResults",
        .intent_level_slot_resolution_test_results = "intentLevelSlotResolutionTestResults",
        .overall_test_results = "overallTestResults",
        .utterance_level_test_results = "utteranceLevelTestResults",
    };
};
