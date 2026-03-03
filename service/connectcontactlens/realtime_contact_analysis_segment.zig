const Categories = @import("categories.zig").Categories;
const PostContactSummary = @import("post_contact_summary.zig").PostContactSummary;
const Transcript = @import("transcript.zig").Transcript;

/// An analyzed segment for a real-time analysis session.
pub const RealtimeContactAnalysisSegment = struct {
    /// The matched category rules.
    categories: ?Categories = null,

    /// Information about the post-contact summary.
    post_contact_summary: ?PostContactSummary = null,

    /// The analyzed transcript.
    transcript: ?Transcript = null,

    pub const json_field_names = .{
        .categories = "Categories",
        .post_contact_summary = "PostContactSummary",
        .transcript = "Transcript",
    };
};
