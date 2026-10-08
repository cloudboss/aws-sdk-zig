const ThreatAnchorShape = @import("threat_anchor_shape.zig").ThreatAnchorShape;
const ThreatActor = @import("threat_actor.zig").ThreatActor;
const ThreatEvidenceShape = @import("threat_evidence_shape.zig").ThreatEvidenceShape;
const ThreatSeverity = @import("threat_severity.zig").ThreatSeverity;
const ThreatStatus = @import("threat_status.zig").ThreatStatus;
const StrideCategory = @import("stride_category.zig").StrideCategory;

/// Represents a threat identified during threat modeling.
pub const Threat = struct {
    /// The DFD element this threat is anchored to.
    anchor: ?ThreatAnchorShape = null,

    /// Optional customer comment on the threat.
    comments: ?[]const u8 = null,

    /// The date and time the threat was created, in UTC format.
    created_at: ?i64 = null,

    /// Who created this threat.
    created_by: ?ThreatActor = null,

    /// The source code files supporting the threat.
    evidence: ?[]const ThreatEvidenceShape = null,

    /// The specific assets affected by the threat.
    impacted_assets: ?[]const []const u8 = null,

    /// The security goals affected by the threat.
    impacted_goal: ?[]const []const u8 = null,

    /// The conditions required for the threat to be exploitable.
    prerequisites: ?[]const u8 = null,

    /// The recommended mitigation guidance for this threat.
    recommendation: ?[]const u8 = null,

    /// The severity level of the threat.
    severity: ?ThreatSeverity = null,

    /// The natural-language threat statement.
    statement: ?[]const u8 = null,

    /// The current status of the threat.
    status: ?ThreatStatus = null,

    /// The STRIDE categories applicable to this threat.
    stride: ?[]const StrideCategory = null,

    /// What the threat source can do.
    threat_action: ?[]const u8 = null,

    /// The unique identifier of the threat.
    threat_id: ?[]const u8 = null,

    /// The direct consequence of the threat action.
    threat_impact: ?[]const u8 = null,

    /// The unique identifier of the threat model job that produced the threat.
    threat_job_id: ?[]const u8 = null,

    /// The actor or origin of the threat.
    threat_source: ?[]const u8 = null,

    /// A short title summarizing the threat.
    title: ?[]const u8 = null,

    /// The date and time the threat was last updated, in UTC format.
    updated_at: ?i64 = null,

    /// Who last updated this threat.
    updated_by: ?ThreatActor = null,

    pub const json_field_names = .{
        .anchor = "anchor",
        .comments = "comments",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .evidence = "evidence",
        .impacted_assets = "impactedAssets",
        .impacted_goal = "impactedGoal",
        .prerequisites = "prerequisites",
        .recommendation = "recommendation",
        .severity = "severity",
        .statement = "statement",
        .status = "status",
        .stride = "stride",
        .threat_action = "threatAction",
        .threat_id = "threatId",
        .threat_impact = "threatImpact",
        .threat_job_id = "threatJobId",
        .threat_source = "threatSource",
        .title = "title",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
