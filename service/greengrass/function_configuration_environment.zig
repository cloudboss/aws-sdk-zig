const aws = @import("aws");

const FunctionExecutionConfig = @import("function_execution_config.zig").FunctionExecutionConfig;
const ResourceAccessPolicy = @import("resource_access_policy.zig").ResourceAccessPolicy;

/// The environment configuration of the function.
pub const FunctionConfigurationEnvironment = struct {
    /// If true, the Lambda function is allowed to access the host's /sys folder.
    /// Use this when the Lambda function needs to read device information from
    /// /sys. This setting applies only when you run the Lambda function in a
    /// Greengrass container.
    access_sysfs: ?bool,

    /// Configuration related to executing the Lambda function
    execution: ?FunctionExecutionConfig,

    /// A list of the resources, with their permissions, to which the Lambda
    /// function will be granted access. A Lambda function can have at most 10
    /// resources. ResourceAccessPolicies apply only when you run the Lambda
    /// function in a Greengrass container.
    resource_access_policies: ?[]const ResourceAccessPolicy,

    /// Environment variables for the Lambda function's configuration.
    variables: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .access_sysfs = "AccessSysfs",
        .execution = "Execution",
        .resource_access_policies = "ResourceAccessPolicies",
        .variables = "Variables",
    };
};
