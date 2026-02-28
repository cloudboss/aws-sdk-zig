const FindingType = @import("finding_type.zig").FindingType;

/// Represents a finding or issue discovered during policy generation or
/// validation. Findings provide insights about potential problems,
/// recommendations, or validation results from policy analysis operations.
/// Finding types include: VALID (policy is ready to use), INVALID (policy has
/// validation errors that must be fixed), NOT_TRANSLATABLE (input couldn't be
/// converted to policy), ALLOW_ALL (policy would allow all actions, potential
/// security risk), ALLOW_NONE (policy would allow no actions, unusable),
/// DENY_ALL (policy would deny all actions, may be too restrictive), and
/// DENY_NONE (policy would deny no actions, ineffective). Review all findings
/// before creating policies from generated assets to ensure they match your
/// security requirements.
pub const Finding = struct {
    /// A human-readable description of the finding. This provides detailed
    /// information about the issue, recommendation, or validation result to help
    /// users understand and address the finding.
    description: ?[]const u8,

    /// The type or category of the finding. This classifies the finding as an
    /// error, warning, recommendation, or informational message to help users
    /// understand the severity and nature of the issue.
    type: ?FindingType,

    pub const json_field_names = .{
        .description = "description",
        .type = "type",
    };
};
