const Definition = @import("definition.zig").Definition;
const FailureHandlingPolicy = @import("failure_handling_policy.zig").FailureHandlingPolicy;
const DeploymentType = @import("deployment_type.zig").DeploymentType;

/// Information about a deployment on an edge device that is registered with
/// SageMaker Edge Manager.
pub const EdgeDeployment = struct {
    /// Returns a list of Definition objects.
    definitions: ?[]const Definition = null,

    /// The name and unique ID of the deployment.
    deployment_name: ?[]const u8 = null,

    /// Determines whether to rollback to previous configuration if deployment
    /// fails.
    failure_handling_policy: ?FailureHandlingPolicy = null,

    /// The type of the deployment.
    @"type": ?DeploymentType = null,

    pub const json_field_names = .{
        .definitions = "Definitions",
        .deployment_name = "DeploymentName",
        .failure_handling_policy = "FailureHandlingPolicy",
        .@"type" = "Type",
    };
};
