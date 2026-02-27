const aws = @import("aws");

const InputArtifact = @import("input_artifact.zig").InputArtifact;
const RuleTypeId = @import("rule_type_id.zig").RuleTypeId;

/// Represents information about the rule to be created for an associated
/// condition. An
/// example would be creating a new rule for an entry condition, such as a rule
/// that checks
/// for a test result before allowing the run to enter the deployment stage. For
/// more
/// information about conditions, see [Stage
/// conditions](https://docs.aws.amazon.com/codepipeline/latest/userguide/stage-conditions.html)
/// and [How do
/// stage conditions
/// work?](https://docs.aws.amazon.com/codepipeline/latest/userguide/concepts-how-it-works-conditions.html). For more information about rules, see the [CodePipeline rule reference](https://docs.aws.amazon.com/codepipeline/latest/userguide/rule-reference.html).
pub const RuleDeclaration = struct {
    /// The shell commands to run with your commands rule in CodePipeline. All
    /// commands
    /// are supported except multi-line formats. While CodeBuild logs and
    /// permissions
    /// are used, you do not need to create any resources in CodeBuild.
    ///
    /// Using compute time for this action will incur separate charges in CodeBuild.
    commands: ?[]const []const u8,

    /// The action configuration fields for the rule.
    configuration: ?[]const aws.map.StringMapEntry,

    /// The input artifacts fields for the rule, such as specifying an input file
    /// for the
    /// rule.
    input_artifacts: ?[]const InputArtifact,

    /// The name of the rule that is created for the condition, such as
    /// `VariableCheck`.
    name: []const u8,

    /// The Region for the condition associated with the rule.
    region: ?[]const u8,

    /// The pipeline role ARN associated with the rule.
    role_arn: ?[]const u8,

    /// The ID for the rule type, which is made up of the combined values for
    /// category, owner,
    /// provider, and version.
    rule_type_id: RuleTypeId,

    /// The action timeout for the rule.
    timeout_in_minutes: ?i32,

    pub const json_field_names = .{
        .commands = "commands",
        .configuration = "configuration",
        .input_artifacts = "inputArtifacts",
        .name = "name",
        .region = "region",
        .role_arn = "roleArn",
        .rule_type_id = "ruleTypeId",
        .timeout_in_minutes = "timeoutInMinutes",
    };
};
