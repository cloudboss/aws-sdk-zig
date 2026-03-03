const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;

/// Defines a disruption compliance recommendation.
pub const RecommendationDisruptionCompliance = struct {
    /// The expected compliance status after applying the recommended configuration
    /// change.
    expected_compliance_status: ComplianceStatus,

    /// The expected Recovery Point Objective (RPO) description after applying the
    /// recommended
    /// configuration change.
    expected_rpo_description: ?[]const u8 = null,

    /// The expected RPO after applying the recommended configuration change.
    expected_rpo_in_secs: i32 = 0,

    /// The expected Recovery Time Objective (RTO) description after applying the
    /// recommended
    /// configuration change.
    expected_rto_description: ?[]const u8 = null,

    /// The expected RTO after applying the recommended configuration change.
    expected_rto_in_secs: i32 = 0,

    pub const json_field_names = .{
        .expected_compliance_status = "expectedComplianceStatus",
        .expected_rpo_description = "expectedRpoDescription",
        .expected_rpo_in_secs = "expectedRpoInSecs",
        .expected_rto_description = "expectedRtoDescription",
        .expected_rto_in_secs = "expectedRtoInSecs",
    };
};
