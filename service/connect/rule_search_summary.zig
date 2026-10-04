const aws = @import("aws");

const ActionSummary = @import("action_summary.zig").ActionSummary;
const PreEvaluationFilters = @import("pre_evaluation_filters.zig").PreEvaluationFilters;
const RulePublishStatus = @import("rule_publish_status.zig").RulePublishStatus;
const RuleCapabilityTier = @import("rule_capability_tier.zig").RuleCapabilityTier;
const RuleTriggerEventSource = @import("rule_trigger_event_source.zig").RuleTriggerEventSource;

/// A summary of information about a rule, returned as part of the response to a
/// `SearchRules`
/// operation.
pub const RuleSearchSummary = struct {
    /// A list of `ActionTypes` associated with a rule.
    action_summaries: []const ActionSummary,

    /// The timestamp for when the rule was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) of the user who last updated the rule.
    last_updated_by: []const u8,

    /// The timestamp for when the rule was last updated.
    last_updated_time: i64,

    /// The name of the rule.
    name: []const u8,

    /// The pre-evaluation filters for the rule, that restrict the rule to be
    /// applied to only certain resources based
    /// on the resource's attributes, such as tags assigned to a contact. The
    /// pre-evaluation filters are applied even before
    /// rule conditions are evaluated and are used to enforce
    /// tag-based-access-control while applying rules.
    pre_evaluation_filters: ?PreEvaluationFilters = null,

    /// The publish status of the rule.
    publish_status: RulePublishStatus,

    /// The Amazon Resource Name (ARN) of the rule.
    rule_arn: []const u8,

    /// The list of capability tiers associated with the rule. Used for categorizing
    /// rules by capability (for example,
    /// `GenerativeAI`).
    rule_capability_tiers: ?[]const RuleCapabilityTier = null,

    /// A unique identifier for the rule.
    rule_id: []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The event source to trigger the rule.
    trigger_event_source: RuleTriggerEventSource,

    pub const json_field_names = .{
        .action_summaries = "ActionSummaries",
        .created_time = "CreatedTime",
        .last_updated_by = "LastUpdatedBy",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .pre_evaluation_filters = "PreEvaluationFilters",
        .publish_status = "PublishStatus",
        .rule_arn = "RuleArn",
        .rule_capability_tiers = "RuleCapabilityTiers",
        .rule_id = "RuleId",
        .tags = "Tags",
        .trigger_event_source = "TriggerEventSource",
    };
};
