const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Represents an operating-system neutral workspace for running and managing
/// tests.
pub const Project = struct {
    /// The project's ARN.
    arn: ?[]const u8,

    /// When the project was created.
    created: ?i64,

    /// The default number of minutes (at the project level) a test run executes
    /// before it times out. The
    /// default value is 150 minutes.
    default_job_timeout_minutes: ?i32,

    /// Environment variables associated with the project.
    environment_variables: ?[]const EnvironmentVariable,

    /// The IAM execution role associated with the project.
    execution_role_arn: ?[]const u8,

    /// The project's name.
    name: ?[]const u8,

    /// The VPC security groups and subnets that are attached to a project.
    vpc_config: ?VpcConfig,

    pub const json_field_names = .{
        .arn = "arn",
        .created = "created",
        .default_job_timeout_minutes = "defaultJobTimeoutMinutes",
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .vpc_config = "vpcConfig",
    };
};
