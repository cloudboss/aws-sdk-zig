const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .overall_test_results => "OverallTestResults",
            .conversation_level_test_results => "ConversationLevelTestResults",
            .intent_classification_test_results => "IntentClassificationTestResults",
            .slot_resolution_test_results => "SlotResolutionTestResults",
            .utterance_level_results => "UtteranceLevelResults",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
