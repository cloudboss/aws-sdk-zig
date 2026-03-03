const aws = @import("aws");

const ArtifactDetail = @import("artifact_detail.zig").ArtifactDetail;
const RuleTypeId = @import("rule_type_id.zig").RuleTypeId;

/// Input information used for a rule execution.
pub const RuleExecutionInput = struct {
    /// Configuration data for a rule execution, such as the resolved values for
    /// that
    /// run.
    configuration: ?[]const aws.map.StringMapEntry = null,

    /// Details of input artifacts of the rule that correspond to the rule
    /// execution.
    input_artifacts: ?[]const ArtifactDetail = null,

    /// The Amazon Web Services Region for the rule, such as us-east-1.
    region: ?[]const u8 = null,

    /// Configuration data for a rule execution with all variable references
    /// replaced with
    /// their real values for the execution.
    resolved_configuration: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the IAM service role that performs the declared rule. This is
    /// assumed
    /// through the roleArn for the pipeline.
    role_arn: ?[]const u8 = null,

    /// The ID for the rule type, which is made up of the combined values for
    /// category, owner,
    /// provider, and version. For more information about conditions, see [Stage
    /// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html). For more information about rules, see the [CodePipeline rule reference](https://docs.aws.amazon.com/codepipeline/latest/userguide/rule-reference.html).
    rule_type_id: ?RuleTypeId = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .input_artifacts = "inputArtifacts",
        .region = "region",
        .resolved_configuration = "resolvedConfiguration",
        .role_arn = "roleArn",
        .rule_type_id = "ruleTypeId",
    };
};
