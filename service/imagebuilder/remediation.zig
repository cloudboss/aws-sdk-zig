const RemediationRecommendation = @import("remediation_recommendation.zig").RemediationRecommendation;

/// Information about how to remediate a finding.
pub const Remediation = struct {
    /// An object that contains information about the recommended course of action
    /// to
    /// remediate the finding.
    recommendation: ?RemediationRecommendation,

    pub const json_field_names = .{
        .recommendation = "recommendation",
    };
};
