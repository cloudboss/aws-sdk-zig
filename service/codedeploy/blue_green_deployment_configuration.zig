const DeploymentReadyOption = @import("deployment_ready_option.zig").DeploymentReadyOption;
const GreenFleetProvisioningOption = @import("green_fleet_provisioning_option.zig").GreenFleetProvisioningOption;
const BlueInstanceTerminationOption = @import("blue_instance_termination_option.zig").BlueInstanceTerminationOption;

/// Information about blue/green deployment options for a deployment group.
pub const BlueGreenDeploymentConfiguration = struct {
    /// Information about the action to take when newly provisioned instances are
    /// ready to
    /// receive traffic in a blue/green deployment.
    deployment_ready_option: ?DeploymentReadyOption = null,

    /// Information about how instances are provisioned for a replacement
    /// environment in a
    /// blue/green deployment.
    green_fleet_provisioning_option: ?GreenFleetProvisioningOption = null,

    /// Information about whether to terminate instances in the original fleet
    /// during a
    /// blue/green deployment.
    terminate_blue_instances_on_deployment_success: ?BlueInstanceTerminationOption = null,

    pub const json_field_names = .{
        .deployment_ready_option = "deploymentReadyOption",
        .green_fleet_provisioning_option = "greenFleetProvisioningOption",
        .terminate_blue_instances_on_deployment_success = "terminateBlueInstancesOnDeploymentSuccess",
    };
};
