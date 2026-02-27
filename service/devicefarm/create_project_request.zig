const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Represents a request to the create project operation.
pub const CreateProjectRequest = struct {
    /// Sets the execution timeout value (in minutes) for a project. All test runs
    /// in this project use the
    /// specified execution timeout value unless overridden when scheduling a run.
    default_job_timeout_minutes: ?i32,

    /// A set of environment variables which are used by default for all runs in the
    /// project.
    /// These environment variables are applied to the test run during the execution
    /// of a test spec file.
    ///
    /// For more information about using test spec files, please see
    /// [Custom test environments
    /// ](https://docs.aws.amazon.com/devicefarm/latest/developerguide/custom-test-environments.html) in *AWS Device
    /// Farm.*
    environment_variables: ?[]const EnvironmentVariable,

    /// An IAM role to be assumed by the test host for all runs in the project.
    execution_role_arn: ?[]const u8,

    /// The project's name.
    name: []const u8,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .default_job_timeout_minutes = "defaultJobTimeoutMinutes",
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .vpc_config = "vpcConfig",
    };
};
