const RealTimeContactAnalysisTranscriptItemWithContent = @import("real_time_contact_analysis_transcript_item_with_content.zig").RealTimeContactAnalysisTranscriptItemWithContent;

/// Potential issues that are detected based on an artificial intelligence
/// analysis of each turn in the
/// conversation.
pub const RealTimeContactAnalysisIssueDetected = struct {
    /// List of the transcript items (segments) that are associated with a given
    /// issue.
    transcript_items: []const RealTimeContactAnalysisTranscriptItemWithContent,

    pub const json_field_names = .{
        .transcript_items = "TranscriptItems",
    };
};
