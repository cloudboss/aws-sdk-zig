const GreenFleetProvisioningAction = @import("green_fleet_provisioning_action.zig").GreenFleetProvisioningAction;

/// Information about the instances that belong to the replacement environment
/// in a
/// blue/green deployment.
pub const GreenFleetProvisioningOption = struct {
    /// The method used to add instances to a replacement environment.
    ///
    /// * `DISCOVER_EXISTING`: Use instances that already exist or will be
    /// created manually.
    ///
    /// * `COPY_AUTO_SCALING_GROUP`: Use settings from a specified Auto Scaling
    ///   group to define and create instances in a new Auto Scaling
    /// group.
    action: ?GreenFleetProvisioningAction = null,

    pub const json_field_names = .{
        .action = "action",
    };
};
