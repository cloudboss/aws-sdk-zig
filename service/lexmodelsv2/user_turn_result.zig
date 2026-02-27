const UserTurnOutputSpecification = @import("user_turn_output_specification.zig").UserTurnOutputSpecification;
const ConversationLevelResultDetail = @import("conversation_level_result_detail.zig").ConversationLevelResultDetail;
const TestResultMatchStatus = @import("test_result_match_status.zig").TestResultMatchStatus;
const ExecutionErrorDetails = @import("execution_error_details.zig").ExecutionErrorDetails;
const UserTurnInputSpecification = @import("user_turn_input_specification.zig").UserTurnInputSpecification;

/// Contains the results for the user turn by the test execution.
pub const UserTurnResult = struct {
    /// Contains information about the actual output for the user turn.
    actual_output: ?UserTurnOutputSpecification,

    /// Contains information about the results related to the conversation
    /// associated with the user turn.
    conversation_level_result: ?ConversationLevelResultDetail,

    /// Specifies whether the expected and actual outputs match or not, or if there
    /// is an error in execution.
    end_to_end_result: ?TestResultMatchStatus,

    error_details: ?ExecutionErrorDetails,

    /// Contains information about the expected output for the user turn.
    expected_output: UserTurnOutputSpecification,

    /// Contains information about the user messages in the turn in the input.
    input: UserTurnInputSpecification,

    /// Specifies whether the expected and actual intents match or not.
    intent_match_result: ?TestResultMatchStatus,

    /// Specifies whether the expected and actual slots match or not.
    slot_match_result: ?TestResultMatchStatus,

    /// Specifies whether the expected and actual speech transcriptions match or
    /// not, or if there is an error in execution.
    speech_transcription_result: ?TestResultMatchStatus,

    pub const json_field_names = .{
        .actual_output = "actualOutput",
        .conversation_level_result = "conversationLevelResult",
        .end_to_end_result = "endToEndResult",
        .error_details = "errorDetails",
        .expected_output = "expectedOutput",
        .input = "input",
        .intent_match_result = "intentMatchResult",
        .slot_match_result = "slotMatchResult",
        .speech_transcription_result = "speechTranscriptionResult",
    };
};
