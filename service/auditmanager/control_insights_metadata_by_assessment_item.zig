const EvidenceInsights = @import("evidence_insights.zig").EvidenceInsights;

/// A summary of the latest analytics data for a specific control in a specific
/// active
/// assessment.
///
/// Control insights are grouped by control domain, and ranked by the highest
/// total count of
/// non-compliant evidence.
pub const ControlInsightsMetadataByAssessmentItem = struct {
    /// The name of the control set that the assessment control belongs to.
    control_set_name: ?[]const u8,

    /// A breakdown of the compliance check status for the evidence that’s
    /// associated with the
    /// assessment control.
    evidence_insights: ?EvidenceInsights,

    /// The unique identifier for the assessment control.
    id: ?[]const u8,

    /// The time when the assessment control insights were last updated.
    last_updated: ?i64,

    /// The name of the assessment control.
    name: ?[]const u8,

    pub const json_field_names = .{
        .control_set_name = "controlSetName",
        .evidence_insights = "evidenceInsights",
        .id = "id",
        .last_updated = "lastUpdated",
        .name = "name",
    };
};
