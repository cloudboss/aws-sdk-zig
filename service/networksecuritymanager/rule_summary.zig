const RuleFirewallType = @import("rule_firewall_type.zig").RuleFirewallType;
const RuleType = @import("rule_type.zig").RuleType;
const EntityStatus = @import("entity_status.zig").EntityStatus;

/// Summary information about a rule.
pub const RuleSummary = struct {
    /// The firewall type associated with the resource.
    firewall_type: ?RuleFirewallType = null,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: []const u8,

    /// The service-generated id of the rule.
    rule_id: []const u8,

    /// The name of the rule.
    rule_name: []const u8,

    /// The type of the rule. `CONFIGURATION` rules contain firewall settings, and
    /// `INSPECTION` rules contain rule groups.
    rule_type: ?RuleType = null,

    /// The current status of the resource: `DRAFT` (unpublished, editable) or
    /// `ACTIVE` (published, in use).
    status: ?EntityStatus = null,

    /// The time when the resource was last updated. For a snapshot, this is the
    /// time when the snapshot was created.
    updated_at: ?i64 = null,

    /// The version of the resource.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_type = "firewallType",
        .has_published_version = "hasPublishedVersion",
        .rule_arn = "ruleArn",
        .rule_id = "ruleId",
        .rule_name = "ruleName",
        .rule_type = "ruleType",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
