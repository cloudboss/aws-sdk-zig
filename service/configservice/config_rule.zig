const ConfigRuleState = @import("config_rule_state.zig").ConfigRuleState;
const EvaluationModeConfiguration = @import("evaluation_mode_configuration.zig").EvaluationModeConfiguration;
const MaximumExecutionFrequency = @import("maximum_execution_frequency.zig").MaximumExecutionFrequency;
const Scope = @import("scope.zig").Scope;
const Source = @import("source.zig").Source;

/// Config rules evaluate the configuration settings of your Amazon Web Services
/// resources. A rule can run when Config detects a configuration change to
/// an Amazon Web Services resource or at a periodic frequency that you choose
/// (for
/// example, every 24 hours). There are two types of rules: *Config Managed
/// Rules* and *Config Custom Rules*.
///
/// Config Managed Rules are predefined,
/// customizable rules created by Config. For a list of managed rules, see
/// [List of Config
/// Managed
/// Rules](https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html).
///
/// Config Custom Rules are rules that you create from scratch. There are two
/// ways to create Config custom rules: with Lambda functions
/// ([ Lambda Developer
/// Guide](https://docs.aws.amazon.com/config/latest/developerguide/gettingstarted-concepts.html#gettingstarted-concepts-function)) and with Guard ([Guard GitHub
/// Repository](https://github.com/aws-cloudformation/cloudformation-guard)), a
/// policy-as-code language.
///
/// Config custom rules created with Lambda
/// are called *Config Custom Lambda Rules* and Config custom rules created with
/// Guard are called *Config Custom Policy Rules*.
///
/// For more information about developing and using Config
/// rules, see [Evaluating Resource with Config
/// Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config.html)
/// in the *Config Developer Guide*.
///
/// You can use the Amazon Web Services CLI and Amazon Web Services SDKs if you
/// want to create
/// a rule that triggers evaluations for your resources when Config delivers the
/// configuration snapshot. For more
/// information, see ConfigSnapshotDeliveryProperties.
pub const ConfigRule = struct {
    /// The Amazon Resource Name (ARN) of the Config
    /// rule.
    config_rule_arn: ?[]const u8,

    /// The ID of the Config rule.
    config_rule_id: ?[]const u8,

    /// The name that you assign to the Config rule. The name is
    /// required if you are adding a new rule.
    config_rule_name: ?[]const u8,

    /// Indicates whether the Config rule is active or is currently
    /// being deleted by Config. It can also indicate the evaluation
    /// status for the Config rule.
    ///
    /// Config sets the state of the rule to
    /// `EVALUATING` temporarily after you use the
    /// `StartConfigRulesEvaluation` request to evaluate your
    /// resources against the Config rule.
    ///
    /// Config sets the state of the rule to
    /// `DELETING_RESULTS` temporarily after you use the
    /// `DeleteEvaluationResults` request to delete the
    /// current evaluation results for the Config rule.
    ///
    /// Config temporarily sets the state of a rule to
    /// `DELETING` after you use the
    /// `DeleteConfigRule` request to delete the rule. After
    /// Config deletes the rule, the rule and all of its evaluations are
    /// erased and are no longer available.
    config_rule_state: ?ConfigRuleState,

    /// Service principal name of the service that created the
    /// rule.
    ///
    /// The field is populated only if the service-linked rule is
    /// created by a service. The field is empty if you create your own
    /// rule.
    created_by: ?[]const u8,

    /// The description that you provide for the Config
    /// rule.
    description: ?[]const u8,

    /// The modes the Config rule can be evaluated in. The valid values are distinct
    /// objects. By default, the value is Detective evaluation mode only.
    evaluation_modes: ?[]const EvaluationModeConfiguration,

    /// A string, in JSON format, that is passed to the Config rule
    /// Lambda function.
    input_parameters: ?[]const u8,

    /// The maximum frequency with which Config runs evaluations
    /// for a rule. You can specify a value for
    /// `MaximumExecutionFrequency` when:
    ///
    /// * This is for an Config managed rule that is triggered at
    /// a periodic frequency.
    ///
    /// * Your custom rule is triggered when Config delivers
    /// the configuration snapshot. For more information, see
    /// ConfigSnapshotDeliveryProperties.
    ///
    /// By default, rules with a periodic trigger are evaluated
    /// every 24 hours. To change the frequency, specify a valid value
    /// for the `MaximumExecutionFrequency`
    /// parameter.
    maximum_execution_frequency: ?MaximumExecutionFrequency,

    /// Defines which resources can trigger an evaluation for the rule.
    /// The scope can include one or more resource types, a combination of
    /// one resource type and one resource ID, or a combination of a tag key
    /// and value. Specify a scope to constrain the resources that can
    /// trigger an evaluation for the rule. If you do not specify a scope,
    /// evaluations are triggered when any resource in the recording group
    /// changes.
    scope: ?Scope,

    /// Provides the rule owner (`Amazon Web Services` for managed rules,
    /// `CUSTOM_POLICY` for Custom Policy rules, and `CUSTOM_LAMBDA` for Custom
    /// Lambda rules), the rule identifier,
    /// and the notifications that cause the function to evaluate your Amazon Web
    /// Services
    /// resources.
    source: Source,

    pub const json_field_names = .{
        .config_rule_arn = "ConfigRuleArn",
        .config_rule_id = "ConfigRuleId",
        .config_rule_name = "ConfigRuleName",
        .config_rule_state = "ConfigRuleState",
        .created_by = "CreatedBy",
        .description = "Description",
        .evaluation_modes = "EvaluationModes",
        .input_parameters = "InputParameters",
        .maximum_execution_frequency = "MaximumExecutionFrequency",
        .scope = "Scope",
        .source = "Source",
    };
};
