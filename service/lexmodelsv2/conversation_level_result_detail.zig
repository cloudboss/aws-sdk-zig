const TestResultMatchStatus = @import("test_result_match_status.zig").TestResultMatchStatus;

/// The conversation level details of the conversation used in the test set.
pub const ConversationLevelResultDetail = struct {
    /// The success or failure of the streaming of the conversation.
    end_to_end_result: TestResultMatchStatus,

    /// The speech transcription success or failure details of the conversation.
    speech_transcription_result: ?TestResultMatchStatus,

    pub const json_field_names = .{
        .end_to_end_result = "endToEndResult",
        .speech_transcription_result = "speechTranscriptionResult",
    };
};
