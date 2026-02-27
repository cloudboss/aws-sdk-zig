const TestResultMatchStatus = @import("test_result_match_status.zig").TestResultMatchStatus;

/// The item listing the evaluation of intent level success or failure.
pub const ConversationLevelIntentClassificationResultItem = struct {
    /// The intent name used in the evaluation of intent level success or failure.
    intent_name: []const u8,

    /// The number of times the specific intent is used in the evaluation of intent
    /// level
    /// success or failure.
    match_result: TestResultMatchStatus,

    pub const json_field_names = .{
        .intent_name = "intentName",
        .match_result = "matchResult",
    };
};
