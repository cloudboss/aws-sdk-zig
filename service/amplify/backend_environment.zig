/// Describes the backend environment associated with a `Branch` of a Gen 1
/// Amplify app. Amplify Gen 1 applications are created
/// using Amplify Studio or the Amplify command line interface
/// (CLI).
pub const BackendEnvironment = struct {
    /// The Amazon Resource Name (ARN) for a backend environment that is part of an
    /// Amplify
    /// app.
    backend_environment_arn: []const u8,

    /// The creation date and time for a backend environment that is part of an
    /// Amplify app.
    create_time: i64,

    /// The name of deployment artifacts.
    deployment_artifacts: ?[]const u8 = null,

    /// The name for a backend environment that is part of an Amplify app.
    environment_name: []const u8,

    /// The AWS CloudFormation stack name of a backend environment.
    stack_name: ?[]const u8 = null,

    /// The last updated date and time for a backend environment that is part of an
    /// Amplify
    /// app.
    update_time: i64,

    pub const json_field_names = .{
        .backend_environment_arn = "backendEnvironmentArn",
        .create_time = "createTime",
        .deployment_artifacts = "deploymentArtifacts",
        .environment_name = "environmentName",
        .stack_name = "stackName",
        .update_time = "updateTime",
    };
};
