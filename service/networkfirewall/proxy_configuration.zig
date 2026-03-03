const ProxyConfigDefaultRulePhaseActionsRequest = @import("proxy_config_default_rule_phase_actions_request.zig").ProxyConfigDefaultRulePhaseActionsRequest;
const ProxyConfigRuleGroup = @import("proxy_config_rule_group.zig").ProxyConfigRuleGroup;
const Tag = @import("tag.zig").Tag;

/// A Proxy Configuration defines the monitoring and protection behavior for a
/// Proxy. The details of the behavior are defined in the rule groups that you
/// add to your configuration.
pub const ProxyConfiguration = struct {
    /// Time the Proxy Configuration was created.
    create_time: ?i64 = null,

    /// Evaluation points in the traffic flow where rules are applied. There are
    /// three phases in a traffic where the rule match is applied.
    ///
    /// Pre-DNS - before domain resolution.
    ///
    /// Pre-Request - after DNS, before request.
    ///
    /// Post-Response - after receiving response.
    default_rule_phase_actions: ?ProxyConfigDefaultRulePhaseActionsRequest = null,

    /// Time the Proxy Configuration was deleted.
    delete_time: ?i64 = null,

    /// A description of the proxy configuration.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a proxy configuration.
    proxy_configuration_arn: ?[]const u8 = null,

    /// The descriptive name of the proxy configuration. You can't change the name
    /// of a proxy configuration after you create it.
    proxy_configuration_name: ?[]const u8 = null,

    /// Proxy rule groups within the proxy configuration.
    rule_groups: ?[]const ProxyConfigRuleGroup = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .default_rule_phase_actions = "DefaultRulePhaseActions",
        .delete_time = "DeleteTime",
        .description = "Description",
        .proxy_configuration_arn = "ProxyConfigurationArn",
        .proxy_configuration_name = "ProxyConfigurationName",
        .rule_groups = "RuleGroups",
        .tags = "Tags",
    };
};
