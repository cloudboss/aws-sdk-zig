const aws = @import("aws");

/// The number of items in the intent classification test.
pub const IntentClassificationTestResultItemCounts = struct {
    /// The number of matched and mismatched results for intent recognition for the
    /// intent.
    intent_match_result_counts: []const aws.map.MapEntry(i32),

    /// The number of matched, mismatched, and execution error results for speech
    /// transcription for the intent.
    speech_transcription_result_counts: ?[]const aws.map.MapEntry(i32),

    /// The total number of results in the intent classification test.
    total_result_count: i32,

    pub const json_field_names = .{
        .intent_match_result_counts = "intentMatchResultCounts",
        .speech_transcription_result_counts = "speechTranscriptionResultCounts",
        .total_result_count = "totalResultCount",
    };
};
