const MaximumExecutionFrequency = @import("maximum_execution_frequency.zig").MaximumExecutionFrequency;
const OrganizationConfigRuleTriggerTypeNoSN = @import("organization_config_rule_trigger_type_no_sn.zig").OrganizationConfigRuleTriggerTypeNoSN;

/// An
/// object that specifies metadata for your organization's Config Custom Policy
/// rule. The metadata includes the runtime system in use, which accounts have
/// debug logging enabled, and other custom rule metadata, such as resource
/// type, resource
/// ID of Amazon Web Services resource, and organization trigger types that
/// initiate Config to evaluate Amazon Web Services resources against a rule.
pub const OrganizationCustomPolicyRuleMetadata = struct {
    /// A list of accounts that you can enable debug logging for your organization
    /// Config Custom Policy rule. List is null when debug logging is enabled for
    /// all accounts.
    debug_log_delivery_accounts: ?[]const []const u8,

    /// The description that you provide for your organization Config Custom Policy
    /// rule.
    description: ?[]const u8,

    /// A string, in JSON format, that is passed to your organization Config Custom
    /// Policy rule.
    input_parameters: ?[]const u8,

    /// The maximum frequency with which Config runs evaluations for a rule. Your
    /// Config Custom Policy rule is triggered when Config delivers
    /// the configuration snapshot. For more information, see
    /// ConfigSnapshotDeliveryProperties.
    maximum_execution_frequency: ?MaximumExecutionFrequency,

    /// The type of notification that initiates Config to run an evaluation for a
    /// rule.
    /// For Config Custom Policy rules, Config supports change-initiated
    /// notification types:
    ///
    /// * `ConfigurationItemChangeNotification` - Initiates an evaluation when
    ///   Config delivers a configuration item as a result of a resource
    /// change.
    ///
    /// * `OversizedConfigurationItemChangeNotification` - Initiates an evaluation
    ///   when
    /// Config delivers an oversized configuration item. Config may generate this
    /// notification type when a resource changes and the
    /// notification exceeds the maximum size allowed by Amazon SNS.
    organization_config_rule_trigger_types: ?[]const OrganizationConfigRuleTriggerTypeNoSN,

    /// The runtime system for your organization Config Custom Policy rules. Guard
    /// is a policy-as-code language that allows you to write policies that are
    /// enforced by Config Custom Policy rules. For more information about Guard,
    /// see the [Guard GitHub
    /// Repository](https://github.com/aws-cloudformation/cloudformation-guard).
    policy_runtime: []const u8,

    /// The policy definition containing the logic for your organization Config
    /// Custom Policy rule.
    policy_text: []const u8,

    /// The ID of the Amazon Web Services resource that was evaluated.
    resource_id_scope: ?[]const u8,

    /// The type of the Amazon Web Services resource that was evaluated.
    resource_types_scope: ?[]const []const u8,

    /// One part of a key-value pair that make up a tag. A key is a general label
    /// that acts like a category for more specific tag values.
    tag_key_scope: ?[]const u8,

    /// The optional part of a key-value pair that make up a tag. A value acts as a
    /// descriptor within a tag category (key).
    tag_value_scope: ?[]const u8,

    pub const json_field_names = .{
        .debug_log_delivery_accounts = "DebugLogDeliveryAccounts",
        .description = "Description",
        .input_parameters = "InputParameters",
        .maximum_execution_frequency = "MaximumExecutionFrequency",
        .organization_config_rule_trigger_types = "OrganizationConfigRuleTriggerTypes",
        .policy_runtime = "PolicyRuntime",
        .policy_text = "PolicyText",
        .resource_id_scope = "ResourceIdScope",
        .resource_types_scope = "ResourceTypesScope",
        .tag_key_scope = "TagKeyScope",
        .tag_value_scope = "TagValueScope",
    };
};
