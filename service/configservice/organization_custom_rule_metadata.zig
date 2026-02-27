const MaximumExecutionFrequency = @import("maximum_execution_frequency.zig").MaximumExecutionFrequency;
const OrganizationConfigRuleTriggerType = @import("organization_config_rule_trigger_type.zig").OrganizationConfigRuleTriggerType;

/// An object that specifies organization custom rule metadata such as resource
/// type, resource ID of Amazon Web Services resource, Lambda function ARN,
/// and organization trigger types that trigger Config to evaluate your Amazon
/// Web Services resources against a rule.
/// It also provides the frequency with which you want Config to run evaluations
/// for the rule if the trigger type is periodic.
pub const OrganizationCustomRuleMetadata = struct {
    /// The description that you provide for your organization Config rule.
    description: ?[]const u8,

    /// A string, in JSON format, that is passed to your organization Config rule
    /// Lambda function.
    input_parameters: ?[]const u8,

    /// The lambda function ARN.
    lambda_function_arn: []const u8,

    /// The maximum frequency with which Config runs evaluations for a rule.
    /// Your custom rule is triggered when Config delivers the configuration
    /// snapshot. For more information, see ConfigSnapshotDeliveryProperties.
    ///
    /// By default, rules with a periodic trigger are evaluated every 24 hours. To
    /// change the frequency, specify a valid
    /// value for the `MaximumExecutionFrequency` parameter.
    maximum_execution_frequency: ?MaximumExecutionFrequency,

    /// The type of notification that triggers Config to run an evaluation for a
    /// rule. You can specify the following notification types:
    ///
    /// * `ConfigurationItemChangeNotification` - Triggers an evaluation when Config
    ///   delivers a configuration item as a result of a resource change.
    ///
    /// * `OversizedConfigurationItemChangeNotification` - Triggers an evaluation
    ///   when Config delivers an oversized configuration item.
    /// Config may generate this notification type when a resource changes and the
    /// notification exceeds the maximum size allowed by Amazon SNS.
    ///
    /// * `ScheduledNotification` - Triggers a periodic evaluation at the frequency
    ///   specified for `MaximumExecutionFrequency`.
    organization_config_rule_trigger_types: []const OrganizationConfigRuleTriggerType,

    /// The ID of the Amazon Web Services resource that was evaluated.
    resource_id_scope: ?[]const u8,

    /// The type of the Amazon Web Services resource that was evaluated.
    resource_types_scope: ?[]const []const u8,

    /// One part of a key-value pair that make up a tag.
    /// A key is a general label that acts like a category for more specific tag
    /// values.
    tag_key_scope: ?[]const u8,

    /// The optional part of a key-value pair that make up a tag.
    /// A value acts as a descriptor within a tag category (key).
    tag_value_scope: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .input_parameters = "InputParameters",
        .lambda_function_arn = "LambdaFunctionArn",
        .maximum_execution_frequency = "MaximumExecutionFrequency",
        .organization_config_rule_trigger_types = "OrganizationConfigRuleTriggerTypes",
        .resource_id_scope = "ResourceIdScope",
        .resource_types_scope = "ResourceTypesScope",
        .tag_key_scope = "TagKeyScope",
        .tag_value_scope = "TagValueScope",
    };
};
