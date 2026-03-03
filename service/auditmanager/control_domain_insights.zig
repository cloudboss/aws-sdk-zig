const EvidenceInsights = @import("evidence_insights.zig").EvidenceInsights;

/// A summary of the latest analytics data for a specific control domain.
///
/// Control domain insights are grouped by control domain, and ranked by the
/// highest total
/// count of non-compliant evidence.
pub const ControlDomainInsights = struct {
    /// The number of controls in the control domain that collected non-compliant
    /// evidence on
    /// the `lastUpdated` date.
    controls_count_by_noncompliant_evidence: ?i32 = null,

    /// A breakdown of the compliance check status for the evidence that’s
    /// associated with the
    /// control domain.
    evidence_insights: ?EvidenceInsights = null,

    /// The unique identifier for the control domain. Audit Manager supports the
    /// control
    /// domains that are provided by Amazon Web Services Control Catalog. For
    /// information about how
    /// to find a list of available control domains, see [
    /// `ListDomains`
    /// ](https://docs.aws.amazon.com/controlcatalog/latest/APIReference/API_ListDomains.html) in the Amazon Web Services Control Catalog API
    /// Reference.
    id: ?[]const u8 = null,

    /// The time when the control domain insights were last updated.
    last_updated: ?i64 = null,

    /// The name of the control domain.
    name: ?[]const u8 = null,

    /// The total number of controls in the control domain.
    total_controls_count: ?i32 = null,

    pub const json_field_names = .{
        .controls_count_by_noncompliant_evidence = "controlsCountByNoncompliantEvidence",
        .evidence_insights = "evidenceInsights",
        .id = "id",
        .last_updated = "lastUpdated",
        .name = "name",
        .total_controls_count = "totalControlsCount",
    };
};
