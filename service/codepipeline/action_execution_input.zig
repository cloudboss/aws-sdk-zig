const aws = @import("aws");

const ActionTypeId = @import("action_type_id.zig").ActionTypeId;
const ArtifactDetail = @import("artifact_detail.zig").ArtifactDetail;

/// Input information used for an action execution.
pub const ActionExecutionInput = struct {
    action_type_id: ?ActionTypeId = null,

    /// Configuration data for an action execution.
    configuration: ?[]const aws.map.StringMapEntry = null,

    /// Details of input artifacts of the action that correspond to the action
    /// execution.
    input_artifacts: ?[]const ArtifactDetail = null,

    /// The variable namespace associated with the action. All variables produced as
    /// output by
    /// this action fall under this namespace.
    namespace: ?[]const u8 = null,

    /// The Amazon Web Services Region for the action, such as us-east-1.
    region: ?[]const u8 = null,

    /// Configuration data for an action execution with all variable references
    /// replaced with
    /// their real values for the execution.
    resolved_configuration: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the IAM service role that performs the declared action. This is
    /// assumed
    /// through the roleArn for the pipeline.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_type_id = "actionTypeId",
        .configuration = "configuration",
        .input_artifacts = "inputArtifacts",
        .namespace = "namespace",
        .region = "region",
        .resolved_configuration = "resolvedConfiguration",
        .role_arn = "roleArn",
    };
};
