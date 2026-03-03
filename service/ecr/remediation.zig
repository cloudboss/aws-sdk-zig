const Recommendation = @import("recommendation.zig").Recommendation;

/// Information on how to remediate a finding.
pub const Remediation = struct {
    /// An object that contains information about the recommended course of action
    /// to
    /// remediate the finding.
    recommendation: ?Recommendation = null,

    pub const json_field_names = .{
        .recommendation = "recommendation",
    };
};
