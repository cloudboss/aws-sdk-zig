const TestResultMatchStatus = @import("test_result_match_status.zig").TestResultMatchStatus;

/// The selection to filter the test set results data at the conversation level.
pub const ConversationLevelTestResultsFilterBy = struct {
    /// The selection of matched or mismatched end-to-end status to filter test set
    /// results data
    /// at the conversation level.
    end_to_end_result: ?TestResultMatchStatus,

    pub const json_field_names = .{
        .end_to_end_result = "endToEndResult",
    };
};
