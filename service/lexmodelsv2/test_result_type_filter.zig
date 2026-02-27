pub const TestResultTypeFilter = enum {
    overall_test_results,
    conversation_level_test_results,
    intent_classification_test_results,
    slot_resolution_test_results,
    utterance_level_results,

    pub const json_field_names = .{
        .overall_test_results = "OverallTestResults",
        .conversation_level_test_results = "ConversationLevelTestResults",
        .intent_classification_test_results = "IntentClassificationTestResults",
        .slot_resolution_test_results = "SlotResolutionTestResults",
        .utterance_level_results = "UtteranceLevelResults",
    };
};
