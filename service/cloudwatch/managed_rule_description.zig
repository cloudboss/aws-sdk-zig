const ManagedRuleState = @import("managed_rule_state.zig").ManagedRuleState;

/// Contains information about managed Contributor Insights rules, as returned
/// by
/// `ListManagedInsightRules`.
pub const ManagedRuleDescription = struct {
    /// If a managed rule is enabled, this is the ARN for the related Amazon Web
    /// Services
    /// resource.
    resource_arn: ?[]const u8,

    /// Describes the state of a managed rule. If present, it contains information
    /// about the
    /// Contributor Insights rule that contains information about the related Amazon
    /// Web Services
    /// resource.
    rule_state: ?ManagedRuleState,

    /// The template name for the managed rule. Used to enable managed rules using
    /// `PutManagedInsightRules`.
    template_name: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .rule_state = "RuleState",
        .template_name = "TemplateName",
    };
};
