const DeploymentOption = @import("deployment_option.zig").DeploymentOption;
const DeploymentType = @import("deployment_type.zig").DeploymentType;

/// Information about the type of deployment, either in-place or blue/green, you
/// want to
/// run and whether to route deployment traffic behind a load balancer.
pub const DeploymentStyle = struct {
    /// Indicates whether to route deployment traffic behind a load balancer.
    deployment_option: ?DeploymentOption = null,

    /// Indicates whether to run an in-place deployment or a blue/green deployment.
    deployment_type: ?DeploymentType = null,

    pub const json_field_names = .{
        .deployment_option = "deploymentOption",
        .deployment_type = "deploymentType",
    };
};
