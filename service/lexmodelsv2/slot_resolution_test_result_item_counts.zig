const aws = @import("aws");

/// Information about the counts for a slot resolution in the results of a test
/// execution.
pub const SlotResolutionTestResultItemCounts = struct {
    /// The number of matched and mismatched results for slot resolution for the
    /// slot.
    slot_match_result_counts: []const aws.map.MapEntry(i32),

    /// The number of matched, mismatched and execution error results for speech
    /// transcription for the slot.
    speech_transcription_result_counts: ?[]const aws.map.MapEntry(i32),

    /// The total number of results.
    total_result_count: i32,

    pub const json_field_names = .{
        .slot_match_result_counts = "slotMatchResultCounts",
        .speech_transcription_result_counts = "speechTranscriptionResultCounts",
        .total_result_count = "totalResultCount",
    };
};
