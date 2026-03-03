const OrganizationConfiguration = @import("organization_configuration.zig").OrganizationConfiguration;
const RecommendedActionType = @import("recommended_action_type.zig").RecommendedActionType;
const RuleType = @import("rule_type.zig").RuleType;
const Schedule = @import("schedule.zig").Schedule;
const RuleStatus = @import("rule_status.zig").RuleStatus;

/// Represents a complete automation rule configuration including criteria,
/// schedule, and execution settings.
pub const AutomationRule = struct {
    /// The 12-digit Amazon Web Services account ID that owns this automation rule.
    account_id: ?[]const u8 = null,

    /// The timestamp when the automation rule was created.
    created_timestamp: ?i64 = null,

    /// A description of the automation rule.
    description: ?[]const u8 = null,

    /// The timestamp when the automation rule was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The name of the automation rule.
    name: ?[]const u8 = null,

    /// Configuration settings for organization-wide rules.
    organization_configuration: ?OrganizationConfiguration = null,

    /// A string representation of a decimal number between 0 and 1 (having up to 30
    /// digits after the decimal point) that determines the priority of the rule.
    /// When multiple rules match the same recommended action, Compute Optimizer
    /// assigns the action to the rule with the lowest priority value (highest
    /// priority), even if that rule is scheduled to run later than other matching
    /// rules.
    priority: ?[]const u8 = null,

    /// List of recommended action types that this rule can execute.
    recommended_action_types: ?[]const RecommendedActionType = null,

    /// The Amazon Resource Name (ARN) of the automation rule.
    rule_arn: ?[]const u8 = null,

    /// The unique identifier of the automation rule.
    rule_id: ?[]const u8 = null,

    /// The revision number of the automation rule.
    rule_revision: ?i64 = null,

    /// The type of automation rule (OrganizationRule or AccountRule).
    rule_type: ?RuleType = null,

    /// The schedule configuration for when the automation rule should execute.
    schedule: ?Schedule = null,

    /// The current status of the automation rule (Active or Inactive).
    status: ?RuleStatus = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .created_timestamp = "createdTimestamp",
        .description = "description",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .name = "name",
        .organization_configuration = "organizationConfiguration",
        .priority = "priority",
        .recommended_action_types = "recommendedActionTypes",
        .rule_arn = "ruleArn",
        .rule_id = "ruleId",
        .rule_revision = "ruleRevision",
        .rule_type = "ruleType",
        .schedule = "schedule",
        .status = "status",
    };
};
