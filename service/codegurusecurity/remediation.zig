const Recommendation = @import("recommendation.zig").Recommendation;
const SuggestedFix = @import("suggested_fix.zig").SuggestedFix;

/// Information about how to remediate a finding.
pub const Remediation = struct {
    /// An object that contains information about the recommended course of action
    /// to remediate a finding.
    recommendation: ?Recommendation,

    /// A list of `SuggestedFix` objects. Each object contains information about a
    /// suggested code fix to remediate the finding.
    suggested_fixes: ?[]const SuggestedFix,

    pub const json_field_names = .{
        .recommendation = "recommendation",
        .suggested_fixes = "suggestedFixes",
    };
};
