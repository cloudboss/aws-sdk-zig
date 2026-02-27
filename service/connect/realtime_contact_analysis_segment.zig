const RealTimeContactAnalysisSegmentAttachments = @import("real_time_contact_analysis_segment_attachments.zig").RealTimeContactAnalysisSegmentAttachments;
const RealTimeContactAnalysisSegmentCategories = @import("real_time_contact_analysis_segment_categories.zig").RealTimeContactAnalysisSegmentCategories;
const RealTimeContactAnalysisSegmentEvent = @import("real_time_contact_analysis_segment_event.zig").RealTimeContactAnalysisSegmentEvent;
const RealTimeContactAnalysisSegmentIssues = @import("real_time_contact_analysis_segment_issues.zig").RealTimeContactAnalysisSegmentIssues;
const RealTimeContactAnalysisSegmentPostContactSummary = @import("real_time_contact_analysis_segment_post_contact_summary.zig").RealTimeContactAnalysisSegmentPostContactSummary;
const RealTimeContactAnalysisSegmentTranscript = @import("real_time_contact_analysis_segment_transcript.zig").RealTimeContactAnalysisSegmentTranscript;

/// An analyzed segment for a real-time analysis session.
pub const RealtimeContactAnalysisSegment = union(enum) {
    /// The analyzed attachments.
    attachments: ?RealTimeContactAnalysisSegmentAttachments,
    categories: ?RealTimeContactAnalysisSegmentCategories,
    event: ?RealTimeContactAnalysisSegmentEvent,
    issues: ?RealTimeContactAnalysisSegmentIssues,
    /// Information about the post-contact summary.
    post_contact_summary: ?RealTimeContactAnalysisSegmentPostContactSummary,
    transcript: ?RealTimeContactAnalysisSegmentTranscript,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .categories = "Categories",
        .event = "Event",
        .issues = "Issues",
        .post_contact_summary = "PostContactSummary",
        .transcript = "Transcript",
    };
};
