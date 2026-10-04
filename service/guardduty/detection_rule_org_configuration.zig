const AssociationMode = @import("association_mode.zig").AssociationMode;
const DetectionRuleConfigurationStatus = @import("detection_rule_configuration_status.zig").DetectionRuleConfigurationStatus;

/// Contains the organization-level configuration for a custom detection rule.
pub const DetectionRuleOrgConfiguration = struct {
    /// The timestamp when the organization configuration was created.
    created_at: i64,

    /// A list of member account IDs excluded from the organization configuration.
    /// Mutually exclusive with `IncludeAccountIds`.
    exclude_account_ids: []const []const u8,

    /// The timestamp when the organization configuration expires.
    expires_at: ?i64 = null,

    /// A list of member account IDs included in the organization configuration.
    /// Mutually exclusive with `ExcludeAccountIds`.
    include_account_ids: []const []const u8,

    /// The execution mode of the organization configuration. Valid values: `LIVE` |
    /// `DRY_RUN`.
    mode: AssociationMode,

    /// The unique identifier for the custom detection rule.
    rule_id: []const u8,

    /// The configuration status. Valid values: `ACTIVE` | `PROCESSING` | `FAILED`.
    status: DetectionRuleConfigurationStatus,

    /// The reason for the current configuration status.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the organization configuration was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .exclude_account_ids = "ExcludeAccountIds",
        .expires_at = "ExpiresAt",
        .include_account_ids = "IncludeAccountIds",
        .mode = "Mode",
        .rule_id = "RuleId",
        .status = "Status",
        .status_reason = "StatusReason",
        .updated_at = "UpdatedAt",
    };
};
