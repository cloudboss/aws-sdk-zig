const ContextGraphStatus = @import("context_graph_status.zig").ContextGraphStatus;
const CentralizationFailureReason = @import("centralization_failure_reason.zig").CentralizationFailureReason;
const RuleHealth = @import("rule_health.zig").RuleHealth;
const TagPropagationFailureReason = @import("tag_propagation_failure_reason.zig").TagPropagationFailureReason;
const TagPropagationStatus = @import("tag_propagation_status.zig").TagPropagationStatus;

/// A summary of a centralization rule's key properties and status.
pub const CentralizationRuleSummary = struct {
    /// The status of context graph centralization for this rule. Returns
    /// `Provisioning` while the context graph is being set up, `Healthy` once it is
    /// active, or `Unhealthy` if provisioning failed. This status is independent of
    /// the overall `RuleHealth` for log delivery.
    context_graph_status: ?ContextGraphStatus = null,

    /// The Amazon Web Services region where the organization centralization rule
    /// was created.
    created_region: ?[]const u8 = null,

    /// The timestamp when the organization centralization rule was created.
    created_time_stamp: ?i64 = null,

    /// The Amazon Web Services Account that created the organization centralization
    /// rule.
    creator_account_id: ?[]const u8 = null,

    /// The primary destination account of the organization centralization rule.
    destination_account_id: ?[]const u8 = null,

    /// The primary destination region of the organization centralization rule.
    destination_region: ?[]const u8 = null,

    /// The reason why an organization centralization rule is marked UNHEALTHY.
    failure_reason: ?CentralizationFailureReason = null,

    /// The timestamp when the organization centralization rule was last updated.
    last_update_time_stamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the organization centralization rule.
    rule_arn: ?[]const u8 = null,

    /// The health status of the organization centralization rule.
    rule_health: ?RuleHealth = null,

    /// The name of the organization centralization rule.
    rule_name: ?[]const u8 = null,

    /// The reason tag propagation is unhealthy for this rule. Only present when
    /// `TagPropagationStatus` is `Unhealthy`.
    tag_propagation_failure_reason: ?TagPropagationFailureReason = null,

    /// The health status of tag propagation for this rule. This status is
    /// independent of the overall `RuleHealth` for log delivery. Returns `Healthy`
    /// when the most recent tag-propagation attempt succeeded, or `Unhealthy` when
    /// the most recent attempt failed.
    tag_propagation_status: ?TagPropagationStatus = null,

    pub const json_field_names = .{
        .context_graph_status = "ContextGraphStatus",
        .created_region = "CreatedRegion",
        .created_time_stamp = "CreatedTimeStamp",
        .creator_account_id = "CreatorAccountId",
        .destination_account_id = "DestinationAccountId",
        .destination_region = "DestinationRegion",
        .failure_reason = "FailureReason",
        .last_update_time_stamp = "LastUpdateTimeStamp",
        .rule_arn = "RuleArn",
        .rule_health = "RuleHealth",
        .rule_name = "RuleName",
        .tag_propagation_failure_reason = "TagPropagationFailureReason",
        .tag_propagation_status = "TagPropagationStatus",
    };
};
