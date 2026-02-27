const TestSetTurnResult = @import("test_set_turn_result.zig").TestSetTurnResult;

/// Contains information about multiple utterances in the results of a test set
/// execution.
pub const UtteranceLevelTestResultItem = struct {
    /// The unique identifier for the conversation associated with the result.
    conversation_id: ?[]const u8,

    /// The record number of the result.
    record_number: i64,

    /// Contains information about the turn associated with the result.
    turn_result: TestSetTurnResult,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .record_number = "recordNumber",
        .turn_result = "turnResult",
    };
};
