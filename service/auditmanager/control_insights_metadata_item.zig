const EvidenceInsights = @import("evidence_insights.zig").EvidenceInsights;

/// A summary of the latest analytics data for a specific control.
///
/// This data reflects the total counts for the specified control across all
/// active
/// assessments. Control insights are grouped by control domain, and ranked by
/// the highest
/// total count of non-compliant evidence.
pub const ControlInsightsMetadataItem = struct {
    /// A breakdown of the compliance check status for the evidence that’s
    /// associated with the
    /// control.
    evidence_insights: ?EvidenceInsights = null,

    /// The unique identifier for the control.
    id: ?[]const u8 = null,

    /// The time when the control insights were last updated.
    last_updated: ?i64 = null,

    /// The name of the control.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .evidence_insights = "evidenceInsights",
        .id = "id",
        .last_updated = "lastUpdated",
        .name = "name",
    };
};
