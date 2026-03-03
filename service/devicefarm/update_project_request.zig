const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Represents a request to the update project operation.
pub const UpdateProjectRequest = struct {
    /// The Amazon Resource Name (ARN) of the project whose name to update.
    arn: []const u8,

    /// The number of minutes a test run in the project executes before it times
    /// out.
    default_job_timeout_minutes: ?i32 = null,

    /// A set of environment variables which are used by default for all runs in the
    /// project.
    /// These environment variables are applied to the test run during the execution
    /// of a test spec file.
    ///
    /// For more information about using test spec files, please see
    /// [Custom test environments
    /// ](https://docs.aws.amazon.com/devicefarm/latest/developerguide/custom-test-environments.html) in *AWS Device
    /// Farm.*
    environment_variables: ?[]const EnvironmentVariable = null,

    /// An IAM role to be assumed by the test host for all runs in the project.
    execution_role_arn: ?[]const u8 = null,

    /// A string that represents the new name of the project that you are updating.
    name: ?[]const u8 = null,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .arn = "arn",
        .default_job_timeout_minutes = "defaultJobTimeoutMinutes",
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .vpc_config = "vpcConfig",
    };
};
