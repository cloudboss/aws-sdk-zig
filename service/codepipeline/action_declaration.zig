const aws = @import("aws");

const ActionTypeId = @import("action_type_id.zig").ActionTypeId;
const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const InputArtifact = @import("input_artifact.zig").InputArtifact;
const OutputArtifact = @import("output_artifact.zig").OutputArtifact;

/// Represents information about an action declaration.
pub const ActionDeclaration = struct {
    /// Specifies the action type and the provider of the action.
    action_type_id: ActionTypeId,

    /// The shell commands to run with your compute action in CodePipeline. All
    /// commands
    /// are supported except multi-line formats. While CodeBuild logs and
    /// permissions
    /// are used, you do not need to create any resources in CodeBuild.
    ///
    /// Using compute time for this action will incur separate charges in CodeBuild.
    commands: ?[]const []const u8 = null,

    /// The action's configuration. These are key-value pairs that specify input
    /// values for
    /// an action. For more information, see [Action Structure Requirements in
    /// CodePipeline](https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#action-requirements). For the list of
    /// configuration properties for the CloudFormation action type in CodePipeline,
    /// see [Configuration Properties
    /// Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/continuous-delivery-codepipeline-action-reference.html) in the *CloudFormation
    /// User Guide*. For template snippets with examples, see [Using Parameter
    /// Override Functions with CodePipeline
    /// Pipelines](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/continuous-delivery-codepipeline-parameter-override-functions.html) in the
    /// *CloudFormation User Guide*.
    ///
    /// The values can be represented in either JSON or YAML format. For example,
    /// the JSON
    /// configuration item format is as follows:
    ///
    /// *JSON:*
    ///
    /// `"Configuration" : { Key : Value },`
    configuration: ?[]const aws.map.StringMapEntry = null,

    /// The environment variables for the action.
    environment_variables: ?[]const EnvironmentVariable = null,

    /// The name or ID of the artifact consumed by the action, such as a test or
    /// build
    /// artifact.
    input_artifacts: ?[]const InputArtifact = null,

    /// The action declaration's name.
    name: []const u8,

    /// The variable namespace associated with the action. All variables produced as
    /// output by
    /// this action fall under this namespace.
    namespace: ?[]const u8 = null,

    /// The name or ID of the result of the action declaration, such as a test or
    /// build
    /// artifact.
    output_artifacts: ?[]const OutputArtifact = null,

    /// The list of variables that are to be exported from the compute action. This
    /// is
    /// specifically CodeBuild environment variables as used for that action.
    output_variables: ?[]const []const u8 = null,

    /// The action declaration's Amazon Web Services Region, such as us-east-1.
    region: ?[]const u8 = null,

    /// The ARN of the IAM service role that performs the declared action. This is
    /// assumed
    /// through the roleArn for the pipeline.
    role_arn: ?[]const u8 = null,

    /// The order in which actions are run.
    run_order: ?i32 = null,

    /// A timeout duration in minutes that can be applied against the ActionType’s
    /// default
    /// timeout value specified in [Quotas for CodePipeline
    /// ](https://docs.aws.amazon.com/codepipeline/latest/userguide/limits.html).
    /// This attribute is available only to the manual approval ActionType.
    timeout_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .action_type_id = "actionTypeId",
        .commands = "commands",
        .configuration = "configuration",
        .environment_variables = "environmentVariables",
        .input_artifacts = "inputArtifacts",
        .name = "name",
        .namespace = "namespace",
        .output_artifacts = "outputArtifacts",
        .output_variables = "outputVariables",
        .region = "region",
        .role_arn = "roleArn",
        .run_order = "runOrder",
        .timeout_in_minutes = "timeoutInMinutes",
    };
};
