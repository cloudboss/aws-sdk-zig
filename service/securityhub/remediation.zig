const Recommendation = @import("recommendation.zig").Recommendation;

/// Details about the remediation steps for a finding.
pub const Remediation = struct {
    /// A recommendation on the steps to take to remediate the issue identified by a
    /// finding.
    recommendation: ?Recommendation,

    pub const json_field_names = .{
        .recommendation = "Recommendation",
    };
};
