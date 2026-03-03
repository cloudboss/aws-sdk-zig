const aws = @import("aws");

/// Information about the overall results for a test execution result.
pub const OverallTestResultItem = struct {
    /// The number of results that succeeded.
    end_to_end_result_counts: []const aws.map.MapEntry(i32),

    /// Indicates whether the conversation contains multiple turns or not.
    multi_turn_conversation: bool = false,

    /// The number of speech transcription results in the overall test.
    speech_transcription_result_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The total number of overall results in the result of the test execution.
    total_result_count: i32,

    pub const json_field_names = .{
        .end_to_end_result_counts = "endToEndResultCounts",
        .multi_turn_conversation = "multiTurnConversation",
        .speech_transcription_result_counts = "speechTranscriptionResultCounts",
        .total_result_count = "totalResultCount",
    };
};
