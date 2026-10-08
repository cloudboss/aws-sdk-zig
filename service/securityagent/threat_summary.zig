const ThreatActor = @import("threat_actor.zig").ThreatActor;
const ThreatSeverity = @import("threat_severity.zig").ThreatSeverity;
const ThreatStatus = @import("threat_status.zig").ThreatStatus;
const StrideCategory = @import("stride_category.zig").StrideCategory;

/// Contains summary information about a threat.
pub const ThreatSummary = struct {
    /// The date and time the threat was created, in UTC format.
    created_at: ?i64 = null,

    /// Who created this threat.
    created_by: ?ThreatActor = null,

    /// The severity level of the threat.
    severity: ?ThreatSeverity = null,

    /// The natural-language threat statement.
    statement: ?[]const u8 = null,

    /// The current status of the threat.
    status: ?ThreatStatus = null,

    /// The STRIDE categories applicable to this threat.
    stride: ?[]const StrideCategory = null,

    /// The unique identifier of the threat.
    threat_id: ?[]const u8 = null,

    /// The unique identifier of the threat model job that produced the threat.
    threat_job_id: ?[]const u8 = null,

    /// A short title summarizing the threat.
    title: ?[]const u8 = null,

    /// The date and time the threat was last updated, in UTC format.
    updated_at: ?i64 = null,

    /// Who last updated this threat.
    updated_by: ?ThreatActor = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .severity = "severity",
        .statement = "statement",
        .status = "status",
        .stride = "stride",
        .threat_id = "threatId",
        .threat_job_id = "threatJobId",
        .title = "title",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
