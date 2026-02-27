pub const RealTimeContactAnalysisSegmentType = enum {
    transcript,
    categories,
    issues,
    event,
    attachments,
    post_contact_summary,

    pub const json_field_names = .{
        .transcript = "Transcript",
        .categories = "Categories",
        .issues = "Issues",
        .event = "Event",
        .attachments = "Attachments",
        .post_contact_summary = "PostContactSummary",
    };
};
