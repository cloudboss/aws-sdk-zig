const AssociationMode = @import("association_mode.zig").AssociationMode;
const DetectionRuleConfigurationStatus = @import("detection_rule_configuration_status.zig").DetectionRuleConfigurationStatus;

/// Contains summary information about an organization-level configuration for a
/// custom detection rule.
pub const DetectionRuleOrgConfigurationSummary = struct {
    /// The timestamp when the organization configuration was created.
    created_at: i64,

    /// The timestamp when the organization configuration expires.
    expires_at: ?i64 = null,

    /// The rule execution mode.
    mode: AssociationMode,

    /// The unique identifier for the custom detection rule.
    rule_id: []const u8,

    /// The configuration status.
    status: DetectionRuleConfigurationStatus,

    /// The reason for the current configuration status.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the organization configuration was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .mode = "Mode",
        .rule_id = "RuleId",
        .status = "Status",
        .status_reason = "StatusReason",
        .updated_at = "UpdatedAt",
    };
};
