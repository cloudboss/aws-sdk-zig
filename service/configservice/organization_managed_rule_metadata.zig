const MaximumExecutionFrequency = @import("maximum_execution_frequency.zig").MaximumExecutionFrequency;

/// An object that specifies organization managed rule metadata such as resource
/// type and ID of Amazon Web Services resource along with the rule identifier.
/// It also provides the frequency with which you want Config to run evaluations
/// for the rule if the trigger type is periodic.
pub const OrganizationManagedRuleMetadata = struct {
    /// The description that you provide for your organization Config rule.
    description: ?[]const u8 = null,

    /// A string, in JSON format, that is passed to your organization Config rule
    /// Lambda function.
    input_parameters: ?[]const u8 = null,

    /// The maximum frequency with which Config runs evaluations for a rule. This is
    /// for an Config managed rule that is triggered at a periodic frequency.
    ///
    /// By default, rules with a periodic trigger are evaluated every 24 hours. To
    /// change the frequency, specify a valid
    /// value for the `MaximumExecutionFrequency` parameter.
    maximum_execution_frequency: ?MaximumExecutionFrequency = null,

    /// The ID of the Amazon Web Services resource that was evaluated.
    resource_id_scope: ?[]const u8 = null,

    /// The type of the Amazon Web Services resource that was evaluated.
    resource_types_scope: ?[]const []const u8 = null,

    /// For organization config managed rules, a predefined identifier from a
    /// list. For example, `IAM_PASSWORD_POLICY` is a managed
    /// rule. To reference a managed rule, see [Using Config managed
    /// rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html).
    rule_identifier: []const u8,

    /// One part of a key-value pair that make up a tag.
    /// A key is a general label that acts like a category for more specific tag
    /// values.
    tag_key_scope: ?[]const u8 = null,

    /// The optional part of a key-value pair that make up a tag.
    /// A value acts as a descriptor within a tag category (key).
    tag_value_scope: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .input_parameters = "InputParameters",
        .maximum_execution_frequency = "MaximumExecutionFrequency",
        .resource_id_scope = "ResourceIdScope",
        .resource_types_scope = "ResourceTypesScope",
        .rule_identifier = "RuleIdentifier",
        .tag_key_scope = "TagKeyScope",
        .tag_value_scope = "TagValueScope",
    };
};
